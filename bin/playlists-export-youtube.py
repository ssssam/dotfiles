#!/bin/bash

mkdir -p /home/sam/Dropbox/Playlists/Youtube
cpe youtube export ssssam54623 | cpe export-split - /home/sam/Dropbox/Playlists/Youtube
