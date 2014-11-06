import os

import waflib.Utils

os.environ['PREFIX'] = os.path.expanduser('~/.local')

def options(ctx):
    ctx.add_option('-i', '--identity', action='store', dest='identity',
                    choices=['me', 'codethink'])

def configure(conf):
    if conf.options.identity is None:
        conf.fatal("No identity set -- you must pass --identity")
    elif conf.options.identity == 'me':
        conf.env.GIT_EMAIL = 'sam@afuera.me.uk'
        conf.env.GIT_EXTRA_CONFIG = ''
    elif conf.options.identity == 'codethink':
        conf.env.GIT_EMAIL = 'sam.thursfield@codethink.co.uk'
        conf.env.GIT_EXTRA_CONFIG = 'gitconfig.codethink-stmp'

# This can be a file or a directory, directories are recursed into
# and everything within is installed.
install_targets = [
    ('bin', '${PREFIX}/bin'),
    ('bash_profile', '~/.bash_profile'),
    ('bashrc', '~/.bashrc'),
    ('gitconfig', '~/.gitconfig'),
    ('gitignore', '~/.gitignore'),
    ('profile', '~/.profile'),
    ('vim', '~/.vim'),
    ('vimrc', '~/.vimrc'),
]

def install_links_to_source_tree(bld, targets):
    for source_path, target_path in targets:
        target_path = waflib.Utils.subst_vars(target_path, bld.env)
        target_path = os.path.expanduser(target_path)

        if not os.path.exists(source_path):
            bld.fatal("Source file '%s' not found." % source_path)

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
    # Task functionality of waf is not used right now because this is
    # such a simple use case.

    bld.exec_command('cp gitconfig.in gitconfig')

    if bld.env.GIT_EXTRA_CONFIG:
        bld.exec_command('cat %s >> gitconfig' % bld.env.GIT_EXTRA_CONFIG)

    bld.exec_command('git config -f gitconfig user.email %s' %
                     bld.env.GIT_EMAIL)


    install_links_to_source_tree(bld, install_targets)
