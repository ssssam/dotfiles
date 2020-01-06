#!/bin/bash

set -e

exec planalyze-gtk $@ \
    --plan ~/Dropbox/Teaching/2018-08\ -\ Summer\ Intensive/*-{FFCE,FCAE}.docx ~/Dropbox/Teaching/2018-2019/*/*-{BE?,CR?,FPET,FFCE}.docx /home/sam/Dropbox/Teaching/2019-2020/*/*\ {BE?,CR?,FPET}\ DAY*.docx \
    --level-map /home/sam/ESL/tools/planalyzer/level_map.json \
    --log ~/Dropbox/Teaching/2018-2019/Log*.docx ~/Dropbox/Teaching/2019-2020/Log*.docx
