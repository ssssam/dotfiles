#!/usr/bin/python3

# Export playlists from XSPF to M3U, for Rhythmbox and other apps to import.
#
# Uses Calliope to convert playlist and Tracker to resolve content locations.

import argparse
import logging
import pathlib
import sys
import warnings

import calliope

# Prettify 'missing location' warnings from convert_to_m3u()
warnings.showwarning = lambda msg, cat, filename, lineno, file=None, line=None: sys.stderr.write(f"Warning: {msg}\n")


def argument_parser():
    parser = argparse.ArgumentParser(description="Playlist Export to M3U")
    parser.add_argument('--debug', dest='debug', action='store_true',
                        help="Enable detailed logging to stderr")
    parser.add_argument('--verbose', dest='verbose', action='store_true',
                        help="Enable logging to stderr")
    parser.add_argument('--delete', action='store_true', default=False,
                        help="Delete all existing .m3u files in OUTPUT dir")
    parser.add_argument('input_path', type=pathlib.Path)
    parser.add_argument('output_path', type=pathlib.Path, nargs='?')
    return parser


def convert_playlist(in_path, out_path=None):
    logging.info("Converting %s to %s", in_path, out_path)
    try:
        contents = calliope.import_.import_(in_path.read_text())
    except RuntimeError as e:
        raise RuntimeError(f"{in_path}: {e.args[0]}\n") from e

    tracker = calliope.tracker.TrackerContext()
    resolved_contents = list(calliope.tracker.resolve_content(tracker, contents))

    n_tracks = len(resolved_contents)
    missing_items = (item for item in resolved_contents if ('location' not in item))
    n_tracks_with_location = len([item for item in resolved_contents
                                  if ('location' in item)])

    if n_tracks_with_location > 0:
        logging.info("Output %s with %i / %i tracks" % (out_path, n_tracks_with_location, n_tracks))

        text = calliope.export.convert_to_m3u(resolved_contents, location_required=False)
        if out_path:
            out_path.write_text(text)
        else:
            sys.stdout.write(text)
            sys.stdout.write('\n')
    else:
        logging.info("Removing empty playlist %s", out_path)
        out_path.unlink()

    for item in missing_items:
        logging.info("Missing: %s - %s", item.get('creator'), item.get('title'))


def main():
    args = argument_parser().parse_args()

    if args.debug:
        logging.basicConfig(stream=sys.stderr, level=logging.DEBUG)
    elif args.verbose:
        logging.basicConfig(stream=sys.stderr, level=logging.INFO)

    if args.output_path and args.output_path.is_dir() and args.delete:
        logging.info("Removing existing .m3u playlists in %s", args.output_path)
        for path in args.output_path.glob('*.m3u'):
            path.unlink()

    if args.input_path.is_dir():
        for in_path in sorted(args.input_path.glob('*.xspf')):
            out_filename = str(in_path.relative_to(args.input_path))
            out_filename = out_filename.replace('/', '_').replace('.xspf', '.m3u')

            # Work around a Rhythmbox bug -- empty title is
            # created if a # appears in the title, triggering crashes later on.
            out_filename = out_filename.replace('#', '')

            out_path = args.output_path.joinpath(out_filename)

            convert_playlist(in_path, out_path)
    else:
        convert_playlist(args.input_path, args.output_path)


try:
    main()
except RuntimeError as e:
    sys.stderr.write("ERROR: {}\n".format(e))
    sys.exit(1)
