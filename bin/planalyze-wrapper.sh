#!/bin/bash

set -e

datadir=$(mktemp -d)
python3 ~/ESL/tools/planalyzer/src/reader/plan_reader.py  ~/Dropbox/Teaching/2018-08\ -\ Summer\ Intensive/*-{FFCE,FCAE}.docx ~/Dropbox/Teaching/2018-2019/*/*-{BE?,CR?,FPET,FFCE}.docx  --level-map /home/sam/ESL/tools/planalyzer/level_map.json > $datadir/plans.json
python3 ~/ESL/tools/planalyzer/src/reader/log_reader.py ~/Dropbox/Teaching/2018-2019/Log.docx ~/Dropbox/Teaching/2018-2019/Log\ term1.docx --levels BE2,BE3,CR2,CR3,FPET,FFCE  > $datadir/logs.json
python3 ~/.local/bin/planalyze-gtk $datadir/plans.json $datadir/logs.json
