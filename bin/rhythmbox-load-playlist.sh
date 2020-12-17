#!/bin/bash
# Read XSPF playlist on stdin and import into Rhythmbox.

set -e

filename=$(mktemp --suffix='.xspf')
url="file://$filename"

cat >/dev/stdin > ${filename}

echo "Starting Rhythmbox"
gdbus call --session \
      --dest org.gnome.Rhythmbox3 \
      --object-path /org/gnome/Rhythmbox3 \
      --method org.gtk.Application.Activate \
      "[]"

echo "Importing ${url} to Rhythmbox"
gdbus call --session \
      --dest org.mpris.MediaPlayer2.rhythmbox \
      --object-path /org/gnome/Rhythmbox3/PlaylistManager \
      --method org.gnome.Rhythmbox3.PlaylistManager.ImportPlaylist \
      "$url"

#rm $filename
