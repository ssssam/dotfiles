#!/bin/bash

set -e -o pipefail

mkdir -p $HOME/Dropbox/Playlists/Youtube
cpe youtube export ssssam54623 | cpe export-split - $HOME/Dropbox/Playlists/Youtube
