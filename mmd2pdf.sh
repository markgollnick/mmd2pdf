#!/bin/bash

argc=($#)
argv=($@)


# Orientation
THIS=`basename \`readlink -e $0\``
WDIR=`dirname  \`readlink -e $0\``/
MMD_DIR="$WDIR/`ls -w 1 --color=never $WDIR | grep -i multimarkdown`/"
WKHTML_DIR="$WDIR/`ls -w 1 --color=never $WDIR | grep -i wkhtml`/"
MATHJAX_JS="$WDIR/`ls -w 1 --color=never $WDIR | grep -i mathjax`/MathJax.js"
STYLE_CSS="$WDIR/style.css"
if [ "${OS//[Ww][Ii][Nn]/}" != "" ]; then # on Windows, transform paths
    MATHJAX_JS=`echo $MATHJAX_JS | sed 's_^\/\([A-Za-z]\)\/_\/\1\:\/_g'`
    STYLE_CSS=`echo $STYLE_CSS   | sed 's_^\/\([A-Za-z]\)\/_\/\1\:\/_g'`
fi


# Initialization
MATH="N"
KEEPHTML="N"
DIR_OUT="."
unset FILE_IN
unset NAME_IN
INIT="N"

IFS=$'\n';
for (( i=0; i<$argc; i++ )); do
    arg="${argv[$i]}"
    if [ "$arg" == "--math" ]; then MATH="Y"
    elif [ "$arg" == "--keep-html" ]; then KEEPHTML="Y"
    elif [ -e "$arg" ]; then
        DIR_OUT=`dirname \`readlink -e $arg\``/
        FILE_IN=`basename \`readlink -e "$arg"\``
        NAME_IN=${FILE_IN%%.*}
        INIT="Y"
    fi
done


# Usage Block
if [ "$INIT" != "Y" ]; then
    echo "
$THIS:
Batch script for easily converting MultiMarkdown texts into PDF documents.
Written by Mark R. Gollnick <mark.r.gollnick@gmail.com>, Spring 2013. &#10013;

Usage:
$THIS [OPTIONS] <input_file.md>

Produces one file of the form \`input_file.pdf' in the same directory
as the input.

To insert page breaks in the resulting PDF, use:
    <div style=\"page-break-after: always;\"></div>

Options:
    --math         Enable TeX equation rendering using MathJax
    --keep-html    Retains the intermediate HTML document used to
                   render the PDF.
"
    exit 1
fi


# STEP 0: Normalize input
MDHTML_OUT="$DIR_OUT/$NAME_IN.md.html"
HEADER_OUT="$DIR_OUT/$NAME_IN.head.html"
HTML_OUT="$DIR_OUT/$NAME_IN.html"
PDF_OUT="$DIR_OUT/$NAME_IN.pdf"

# STEP 1: Markdown to HTML
$MMD_DIR/multimarkdown "$FILE_IN" > "$MDHTML_OUT"

# STEP 2: Format HTML
(echo \<!DOCTYPE html\>)>$HEADER_OUT
(echo \<html\>)>>$HEADER_OUT
(echo \<head\>)>>$HEADER_OUT
(echo \<meta charset=\"utf-8\"/\>)>>$HEADER_OUT
(echo \<title\>$NAME_IN\</title\>)>>$HEADER_OUT
(echo \<link type=\"text/css\" rel=\"stylesheet\" href=\"file://$STYLE_CSS\" /\>)>>$HEADER_OUT
if [ "$MATH" == "Y" ]; then
    (echo \<script type=\"text/javascript\" src=\"file://$MATHJAX_JS?config=pdf\"\>)>>$HEADER_OUT
    (echo \</script\>)>>$HEADER_OUT
fi
(echo \</head\>)>>$HEADER_OUT
(echo \<body\>)>>$HEADER_OUT
cat $HEADER_OUT $MDHTML_OUT > $HTML_OUT
(echo \</body\>\</html\>)>>$HTML_OUT
rm -f $HEADER_OUT $MDHTML_OUT

# STEP 3: HTML to PDF
if [ "$MATH" == "N" ]; then
    $WKHTML_DIR/wkhtmltopdf --margin-top 1in --margin-right 1in --margin-bottom 1in --margin-left 1in --enable-external-links --enable-internal-links --footer-center "Page [page] of [toPage]" --footer-font-name "Verdana" --footer-font-size 11 "$HTML_OUT" "$PDF_OUT"
else
    $WKHTML_DIR/wkhtmltopdf --margin-top 1in --margin-right 1in --margin-bottom 1in --margin-left 1in --enable-external-links --enable-internal-links --footer-center "Page [page] of [toPage]" --footer-font-name "Verdana" --footer-font-size 11 --enable-javascript --javascript-delay 5000 "$HTML_OUT" "$PDF_OUT"
fi
if [ "$KEEPHTML" == "N" ]; then
    rm -f $HTML_OUT
fi

echo "Wrote as $PDF_OUT. Have a nice day!"
