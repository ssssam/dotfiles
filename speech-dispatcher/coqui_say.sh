#!/bin/sh

# coqui_say - for use with speech-dispatcher Generic module.
#
# Based on https://github.com/brailcom/speechd/blob/95e7a9cb1f1e16a76857f525e31ec3b201e2ab2b/config/modules/mary-generic.conf

set -eux

env

INPUT_TEXT=$(echo $DATA | python3 -c 'import urllib.parse, sys; text=sys.stdin.read().strip(); print(urllib.parse.quote(text))')

echo $INPUT_TEXT > /tmp/coqui.txt
curl "http://localhost:5002/process?INPUT_TEXT=$INPUT_TEXT&INPUT_TYPE=TEXT&OUTPUT_TYPE=AUDIO&AUDIO=WAVE_FILE&LOCALE=$LANGUAGE&VOICE=$VOICE" | \
    sox -v $VOLUME - $TMPDIR/coqui-generic.wav tempo $RATE pitch $PITCH norm && \
    $PLAY_COMMAND $TMPDIR/coqui-generic.wav
