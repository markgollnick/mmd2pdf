#!/bin/bash
# mmd2pdf.sh
# @author Mark R. Gollnick <mark.r.gollnick@gmail.com> &#10013;
# @license Boost Software Licence v1.0 <http://www.boost.org/LICENSE_1_0.txt>
# @date Mon, 09 Aug 2013 10:36:40 -0500
# @desc Convert Multi-Markdown text files to PDF files, easily.

ARGC=($#)
ARGV=($@)
WDIR=$([[ $0 == /* ]] && echo "${0%/*}" || echo "${PWD}/${0%/*}")
THIS=$([[ $0 == /* ]] && echo "${0##*/}" || echo "${0##*/}")
POS=$'/'
DOS=$'\\\\'


# Orientation
STYLE_CSS="$WDIR/style.css"
case "$OS" in *"Win"*)
    STYLE_CSS=/${STYLE_CSS:1:1}:${STYLE_CSS:2}
;; esac
STYLE_CSS="file://$STYLE_CSS"


# Initialization
MATH="N"
KEEPHTML="N"
DIR_OUT="."
unset FILE_IN
unset NAME_IN
INIT="N"

SAVE_IFS=$IFS
IFS=$'\n';
for (( i=0; i<$ARGC; i++ )); do
    arg="${ARGV[$i]}"
    if [ "$arg" == "--math" ]; then MATH="Y"
    elif [ "$arg" == "--keep-html" ]; then KEEPHTML="M"
    elif [ "$arg" == "--no-pdf" ]; then KEEPHTML="Y"
    elif [ -e "$arg" ]; then
        DIR_OUT=$(dirname `readlink -e "$arg"`)
        FILE_IN=$(basename `readlink -e "$arg"`)
        NAME_IN=${FILE_IN%.*}
        INIT="Y"
    fi
done


# Usage Block
if [ "$INIT" != "Y" ]; then
    echo "
$THIS:
Shell script for easily converting MultiMarkdown texts into PDF documents.
Written by Mark R. Gollnick <mark.r.gollnick@gmail.com>, Fall 2013. &#10013;

Requirements:
    MultiMarkdown:  fletcherpenny.net/multimarkdown
    wkhtmltopdf:    code.google.com/p/wkhtmltopdf

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
    --no-pdf       Do not generate PDF, only HTML. For previewing.
"
    exit 1
fi


# STEP 0: Normalize input
MDHTML_OUT="$DIR_OUT/$NAME_IN.md.html"
HEADER_OUT="$DIR_OUT/$NAME_IN.head.html"
HTML_OUT="$DIR_OUT/$NAME_IN.html"
PDF_OUT="$DIR_OUT/$NAME_IN.pdf"

# STEP 1: Markdown to HTML
multimarkdown "$FILE_IN" > "$MDHTML_OUT"

# STEP 2: Format HTML
(echo \<!DOCTYPE html\>)>$HEADER_OUT
(echo \<html\>)>>$HEADER_OUT
(echo \<head\>)>>$HEADER_OUT
(echo \<meta charset=\"utf-8\"/\>)>>$HEADER_OUT
(echo \<title\>$NAME_IN\</title\>)>>$HEADER_OUT
(echo \<link type=\"text/css\" rel=\"stylesheet\" href=\"$STYLE_CSS\" /\>)>>$HEADER_OUT
if [ "$MATH" == "Y" ]; then
    (echo \<script type=\"text/javascript\" src=\"http://cdn.mathjax.org/mathjax/latest/MathJax.js?config=$PDF_JS\"\>)>>$HEADER_OUT
    (echo \</script\>)>>$HEADER_OUT
fi
(echo \</head\>)>>$HEADER_OUT
(echo \<body\>)>>$HEADER_OUT
cat $HEADER_OUT $MDHTML_OUT > $HTML_OUT
(echo \</body\>\</html\>)>>$HTML_OUT
rm -f $HEADER_OUT $MDHTML_OUT

# STEP 3: HTML to PDF
if [ "$KEEPHTML" != "Y" ]; then
    if [ "$MATH" == "N" ]; then
        wkhtmltopdf --margin-top 1in --margin-right 1in --margin-bottom 1in --margin-left 1in --enable-external-links --enable-internal-links --footer-center "Page [page] of [toPage]" --footer-font-name "Verdana" --footer-font-size 11 "$HTML_OUT" "$PDF_OUT"
    else
        wkhtmltopdf --margin-top 1in --margin-right 1in --margin-bottom 1in --margin-left 1in --enable-external-links --enable-internal-links --footer-center "Page [page] of [toPage]" --footer-font-name "Verdana" --footer-font-size 11 --enable-javascript --javascript-delay 10000 "$HTML_OUT" "$PDF_OUT"
    fi
fi
if [ "$KEEPHTML" == "N" ]; then
    rm -f $HTML_OUT
fi
if [ "$KEEPHTML" == "Y" ]; then
    echo "Wrote as $HTML_OUT. Have a nice day!"
else
    echo "Wrote as $PDF_OUT. Have a nice day!"
fi
