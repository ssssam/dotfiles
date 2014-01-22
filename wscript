import os

import waflib.Utils

os.environ['PREFIX'] = os.path.expanduser('~/.local')

def configure(conf):
    pass

# This can be a file or a directory, directories are recursed into
# and everything within is installed.
install_targets = [
    ('bin', '${PREFIX}/bin'),
    ('vim', '~/.vim'),
    ('vimrc', '~/.vimrc'),
]

def install_links_to_source_tree(bld, targets):
    for source_path, target_path in targets:
        target_path = waflib.Utils.subst_vars(target_path, bld.env)
        target_path = os.path.expanduser(target_path)

        if not os.path.exists(target_path):
            bld.symlink_as(target_path, os.path.abspath(source_path))
        else:
            if os.path.isdir(source_path):
                subdir_targets = [
                    (os.path.join(source_path, file),
                     os.path.join(target_path, file))
                     for file in os.listdir(source_path)]
                install_links_to_source_tree(bld, subdir_targets)

def build(bld):
    install_links_to_source_tree(bld, install_targets)
