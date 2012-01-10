#!/bin/bash

set -e

BASENAME=$1
SUFFIX=$2

echo Basename = $BASENAME
echo Suffix = $SUFFIX
if [ -a $BASENAME ]; then
	rm -rf $BASENAME
fi

lilypond-book --output=$BASENAME --pdf $BASENAME.$SUFFIX

cd $BASENAME
pdftex --synctex=1 -undump=pdflatex $BASENAME.tex

copy $BASENAME.pdf ../
