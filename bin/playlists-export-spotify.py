#!/bin/bash

mkdir -p /home/sam/Dropbox/Playlists/Spotify
cpe spotify export | cpe export-split - /home/sam/Dropbox/Playlists/Spotify
