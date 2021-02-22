systemd_user_unit_dir = configdir / 'systemd' / 'user'

units = [
  'sync-rhythmbox-playlists.path',
  'sync-rhythmbox-playlists.service',
  'sync-spotify-playlists.service',
  'sync-spotify-playlists.timer',
  'sync-youtube-playlists.service',
  'sync-youtube-playlists.timer',
]

foreach unit : units
  install_data(unit,
    install_dir: systemd_user_unit_dir)
endforeach

enable_units = [
  'sync-rhythmbox-playlists.path',
  'sync-spotify-playlists.timer',
  'sync-youtube-playlists.timer',
]

foreach unit : enable_units
  from = get_option('prefix') / systemd_user_unit_dir / unit
  to = get_option('prefix') / systemd_user_unit_dir / 'default.target.wants' / unit
  meson.add_install_script('sh', '-c', 'mkdir -p $(dirname "@1@") && ln -sf "@0@" "@1@"'.format(from, to))
endforeach
