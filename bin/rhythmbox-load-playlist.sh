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

# FIXME: Rhythmbox seems to not show the GUI if we call the next API without
# sleeping first.
sleep 1

echo "Importing ${url} to Rhythmbox"
gdbus call --session \
      --dest org.mpris.MediaPlayer2.rhythmbox \
      --object-path /org/gnome/Rhythmbox3/PlaylistManager \
      --method org.gnome.Rhythmbox3.PlaylistManager.ImportPlaylist \
      "$url"

rm $filename
