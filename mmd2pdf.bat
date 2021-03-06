@echo off
rem mmd2pdf.bat
rem @author Mark R. Gollnick <mark.r.gollnick@gmail.com> &#10013;
rem @license Boost Software Licence v1.0 <http://www.boost.org/LICENSE_1_0.txt>
rem @date Fri, 30 Oct 2013 21:04:10 -0500
rem @desc Convert Multi-Markdown text files to PDF files, easily.


:: Orientation
for /F "usebackq delims=" %%F in (`echo %~dpnx0`) do (
    set WDIR=%%~dpF
    set THIS=%%~nxF
)
set WDIR=%WDIR:~0,-1%
set STYLE_CSS=%WDIR%\css\style.css
set MATHJAX_JS=%WDIR%\externals\MathJax\MathJax.js
set CONFIG_JS=%WDIR%\js\config.js
set HIGHLIGHT_JS=%WDIR%\externals\highlight.min.js
set HIGHLIGHT_CSS=%WDIR%\externals\highlight.js\src\styles\github.css


:: Initialization
set MATH=N
set KEEPHTML=N
set DIR_OUT=.\
set FILE_IN=
set NAME_IN=
set INIT=N

for %%A in (%*) do (
    if /I "%%~A"=="/MATH" set MATH=Y
    if /I "%%~A"=="/KEEPHTML" set KEEPHTML=M
    if /I "%%~A"=="/NOPDF" set KEEPHTML=Y
    if exist "%%~A" (
        set DIR_OUT=%%~dpA
        set FILE_IN=%%~dpnxA
        set NAME_IN=%%~nA
        set INIT=Y
    )
)
set DIR_OUT=%DIR_OUT:~0,-1%
if /I "%INIT%"=="N" goto usage
goto run


:: Usage Block
:usage
echo %THIS%:
echo Batch script for easily converting MultiMarkdown texts into PDF documents.
echo Written by Mark R. Gollnick ^<mark.r.gollnick@gmail.com^>, Spring 2013. ^&#10013;
echo.
echo Requirements:
echo     MultiMarkdown:  fletcherpenny.net/multimarkdown
echo     wkhtmltopdf:    code.google.com/p/wkhtmltopdf
echo.
echo Usage:
echo     %THIS% [OPTIONS] ^<input_file.md^>
echo.
echo Produces one file of the form `input_file.pdf' in the same directory
echo as the input.
echo.
echo To insert page breaks in the resulting PDF, use:
echo     ^<div style="page-break-after: always;"^>^</div^>
echo.
echo Options:
echo     /MATH          Enable TeX equation rendering using MathJax
echo     /KEEPHTML      Retains the intermediate HTML document used to
echo                    render the PDF.
echo     /NOPDF         Do not generate PDF, only HTML. For previewing.
goto eof
exit


:run
:: STEP 0: Normalize input
set MDHTML_OUT=%DIR_OUT%\%NAME_IN%.md.html
set HEADER_OUT=%DIR_OUT%\%NAME_IN%.head.html
set HTML_OUT=%DIR_OUT%\%NAME_IN%.html
set PDF_OUT=%DIR_OUT%\%NAME_IN%.pdf

:: STEP 1: Markdown to HTML
multimarkdown.exe "%FILE_IN%" > "%MDHTML_OUT%"

:: STEP 2: Format HTML
(echo ^<!DOCTYPE html^>)>%HEADER_OUT%
(echo ^<html^>)>>%HEADER_OUT%
(echo ^<head^>)>>%HEADER_OUT%
(echo ^<meta charset="utf-8" /^>)>>%HEADER_OUT%
(echo ^<title^>%NAME_IN%^</title^>)>>%HEADER_OUT%
(echo ^<link type="text/css" rel="stylesheet" href="%STYLE_CSS%" /^>)>>%HEADER_OUT%
(echo ^<link type="text/css" rel="stylesheet" href="%HIGHLIGHT_CSS%" /^>)>>%HEADER_OUT%
if "%MATH%"=="Y" goto mathjax else goto resume
:mathjax
(echo ^<script type="text/x-mathjax-config"^>)>>%HEADER_OUT%
(type %CONFIG_JS%)>>%HEADER_OUT%
(echo ^</script^>)>>%HEADER_OUT%
(echo ^<script type="text/javascript" src="%MATHJAX_JS%"^>)>>%HEADER_OUT%
(echo ^</script^>)>>%HEADER_OUT%
(echo ^<script type="text/javascript" src="%HIGHLIGHT_JS%"^>)>>%HEADER_OUT%
(echo ^</script^>)>>%HEADER_OUT%
goto resume
:resume
(echo ^</head^>)>>%HEADER_OUT%
(echo ^<body^>)>>%HEADER_OUT%
(copy /B /Y %HEADER_OUT% + %MDHTML_OUT% %HTML_OUT%)>nul
(echo ^<script type="text/javascript"^>)>>%HTML_OUT%
(echo hljs.tabReplace = '    '; //4 spaces)>>%HTML_OUT%
(echo hljs.initHighlightingOnLoad^(^);)>>%HTML_OUT%
(echo ^</script^>)>>%HTML_OUT%
(echo ^</body^>)>>%HTML_OUT%
(echo ^</html^>)>>%HTML_OUT%
(del /F /Q %HEADER_OUT% %MDHTML_OUT%)>nul

:: STEP 3: HTML to PDF
if /I not "%KEEPHTML%"=="Y" (
    if "%MATH%"=="N" (
        wkhtmltopdf.exe --margin-top 1in --margin-right 1in --margin-bottom 1in --margin-left 1in --enable-external-links --enable-internal-links --footer-center "Page [page] of [toPage]" --footer-font-name "Verdana" --footer-font-size 11 "%HTML_OUT%" "%PDF_OUT%"
    ) else (
        wkhtmltopdf.exe --margin-top 1in --margin-right 1in --margin-bottom 1in --margin-left 1in --enable-external-links --enable-internal-links --footer-center "Page [page] of [toPage]" --footer-font-name "Verdana" --footer-font-size 11 --enable-javascript --javascript-delay 10000 "%HTML_OUT%" "%PDF_OUT%"
    )
)
if /I "%KEEPHTML%"=="N" (
    (del /F /Q %HTML_OUT%)>nul
)
if /I "%KEEPHTML%"=="Y" (
    echo Wrote as %HTML_OUT%. Have a nice day!
) else (
    echo Wrote as %PDF_OUT%. Have a nice day!
)
:eof
