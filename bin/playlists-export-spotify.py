#!/bin/bash

set -e -o pipefail

mkdir -p $HOME/Dropbox/Playlists/Spotify
cpe spotify export | cpe export-split - $HOME/Dropbox/Playlists/Spotify
