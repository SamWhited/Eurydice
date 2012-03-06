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
pdflatex --synctex=1 $BASENAME.tex

cp $BASENAME.pdf ../
