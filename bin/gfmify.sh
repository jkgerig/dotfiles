#!/bin/bash

# Convert a (github-flavored) markdown file into HTML
# with github-style css rendering using pandoc.

# css courtesy of: github.com/sindresorhus/github-markdown-css

IN_FILE="$1"
OUT_FILE=$(basename $IN_FILE | sed -r -e "s/\.md/.html/")

echo '<style>' > $OUT_FILE
cat ${HOME}/.lib/github-markdown.css >> $OUT_FILE
echo '</style>' >> $OUT_FILE
echo '<article class="markdown-body">' >> $OUT_FILE

pandoc -f markdown_github $IN_FILE >> $OUT_FILE

echo '</article>' >> $OUT_FILE
