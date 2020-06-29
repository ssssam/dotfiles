#!/usr/bin/python3

import argparse
import os
import subprocess
import sys
import tempfile


def argument_parser():
    parser = argparse.ArgumentParser(
        description="Update specfile from Git repo")
    parser.add_argument('--debug', dest='debug', action='store_true',
                        help="Enable detailed logging to stderr")
    parser.add_argument('repo', help="Path to Git repository")
    parser.add_argument('specfile', help="Spec file")
    return parser


def get_master_sha1(repo):
    result = subprocess.run(['git', '-C', repo, 'rev-parse', 'master'],
                            capture_output=True, check=True)
    return result.stdout.decode('utf-8').strip()


def find_first_digit(text):
    for i in range(0, len(text)):
        if text[i].isdigit():
            return i
    return None


def update_spec_githash(specfile_path, githash):
    out = tempfile.NamedTemporaryFile(delete=False, mode='w', encoding='utf-8',
                                      dir=os.path.dirname(specfile_path))
    try:
        with open(specfile_path, 'r', encoding='utf-8') as specfile:
            for line in specfile:
                if line.startswith('%global githash '):
                    # Update githash
                    out.write('%global githash ' + githash + '\n')
                elif line.startswith('Release:'):
                    # Update releasever
                    first_digit = find_first_digit(line)

                    prefix = line[:first_digit]
                    digits_str = ''.join([d for d in line[first_digit:] if d.isdigit()])
                    tail_str = line[first_digit + len(digits_str):]

                    out.write(prefix + str(int(digits_str) + 1) + tail_str)
                else:
                    out.write(line)
        os.rename(out.name, specfile_path)
    except Exception:
        os.unlink(out.name)
        raise


def main():
    args = argument_parser().parse_args()
    ref = get_master_sha1(args.repo)
    update_spec_githash(args.specfile, ref)


try:
    main()
except RuntimeError as e:
    sys.stderr.write("ERROR: {}\n".format(e))
    sys.exit(1)
