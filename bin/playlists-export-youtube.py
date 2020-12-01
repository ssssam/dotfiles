#!/bin/bash

mkdir -p /home/sam/Dropbox/Playlists/Youtube
cpe spotify export | cpe export-split - /home/sam/Dropbox/Playlists/Youtube
