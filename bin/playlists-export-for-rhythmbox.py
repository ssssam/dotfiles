#!/usr/bin/python3

import pathlib
import sys
import warnings

import calliope

# Prettify 'missing location' warnings from convert_to_m3u()
warnings.showwarning = lambda msg, cat, filename, lineno, file=None, line=None: sys.stderr.write(f"Warning: {msg}\n")

playlists_path = pathlib.Path(sys.argv[1])
rb_playlists_path = pathlib.Path(sys.argv[2])

# Remove old ones.
for path in rb_playlists_path.glob('*.m3u'):
    path.unlink()


for path in playlists_path.rglob('**/*.xspf'):
    if path.parts[-2] == 'Rhythmbox':
        continue

    try:
        contents = calliope.import_.import_(path.read_text())
    except RuntimeError as e:
        sys.stderr.write(f"{path}: {e.args[0]}\n")
        continue

    n_tracks_with_location = len(list(item for item in contents if ('location' in item)))

    if n_tracks_with_location > 0:
        print("Output %s with %i tracks" % (path.name, n_tracks_with_location))

        output_filename = str(path.relative_to(playlists_path))
        output_filename = output_filename.replace('/', '_').replace('.xspf', '.m3u')

        # Work around a Rhythmbox bug -- empty title is
        # created if a # appears in the title, triggering crashes later on.
        output_filename = output_filename.replace('#', '')

        output_path = rb_playlists_path.joinpath(output_filename)
        output_path.write_text(calliope.export.convert_to_m3u(contents, location_required=False))
