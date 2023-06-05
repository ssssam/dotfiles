project('Sam\'s dotfiles', meson_version: '>= 0.61')

message('This is intended to install with --prefix = $HOME')

fs = import('fs')

configdir = '.config'
bindir = '.local' / 'bin'
datadir = '.local' / 'share'
dropboxdir = 'Dropbox'

source_tree_symlinks = [
  ['applications/planalyze.desktop', datadir / 'applications/planalyze.desktop'],
  ['bin/baserock-format-patches', bindir / 'baserock-format-patches'],
  ['bin/fetch-list', bindir / 'fetch-list'],
  ['bin/git-active-days', bindir / 'git-active-days'],
  ['bin/git-backport-merge', bindir / 'git-backport-merge'],
  ['bin/git-conflicts', bindir / 'git-conflicts'],
  ['bin/git-mtime', bindir / 'git-mtime'],
  ['bin/morph-list-branches', bindir / 'morph-list-branches'],
  ['bin/planalyze-wrapper.sh', bindir / 'planalyze-wrapper.sh'],
  ['bin/playlists-export-for-rhythmbox.py', bindir / 'playlists-export-for-rhythmbox'],
  ['bin/playlists-export-spotify.py', bindir / 'playlists-export-spotify'],
  ['bin/playlists-export-youtube.py', bindir / 'playlists-export-youtube'],
  ['bin/rhythmbox-load-playlist.sh', bindir / 'rhythmbox-load-playlist'],
  ['bin/update-specfile-from-git.py', bindir / 'update-specfile-from-git'],
  ['bashrc', '.bashrc'],
  ['beets/config.yaml', configdir / 'beets/config.yaml'],
  ['flexget/config.yml', configdir / 'flexget/config.yml'],
  ['fish/config.fish', configdir / 'fish/config.fish'],
  ['nushell/config.nu', configdir / 'nushell/config.nu'],
  ['nushell/env.nu', configdir / 'nushell/env.nu'],
  ['speech-dispatcher', configdir / 'speech-dispatcher'],
  ['gitconfig', '.gitconfig'],
  ['gitignore', '.gitignore'],
  ['profile', '.profile'],
  ['vim', '.vim'],
  ['vimrc', '.vimrc'],
]

home_symlinks = [
  [dropboxdir / 'db-config.sqlite', configdir / 'flexget/db-config.sqlite'],
]

foreach symlink : source_tree_symlinks
  target = meson.global_source_root() / symlink[0]
  install_dir = get_option('prefix') / fs.parent(symlink[1])
  link_name = fs.name(symlink[1])
  install_symlink(link_name, install_dir: install_dir, pointing_to: target)
endforeach

foreach symlink : home_symlinks
  target = get_option('prefix') / symlink[0]
  if fs.exists(target)
    install_dir = get_option('prefix') / fs.parent(symlink[1])
    link_name = fs.name(symlink[1])
    install_symlink(link_name, install_dir: install_dir, pointing_to: target)
  endif
endforeach

subdir('rhythmbox')
subdir('systemd')
