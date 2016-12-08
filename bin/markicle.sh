#!/bin/bash

# Convert a markdown file into HTML using pandoc and custom css
# CSS from csszengarden.com/217/217.css

CSS="~/.lib/css/217.css"
IN_FILE="$1"
OUT_FILE=$(basename $IN_FILE | sed -r -e 's/\.md/.html/')

pandoc -H $CSS -f markdown -t html5 -o $OUT_FILE $IN_FILE

