MMD2PDF
=======

Convert Multi-Markdown text files to PDF files, easily!


Purpose
-------

To generate a pretty PDF file from a Markdown-formatted text document,
without requiring the user to install TeX-Live (because it EATS GIGABYTES).


Requirements
------------

* MultiMarkdown: <http://fletcherpenney.net/multimarkdown/download/>
* wkhtmltopdf: <https://code.google.com/p/wkhtmltopdf/>
* MathJax (for LaTeX equation support): <http://www.mathjax.org/>


Usage
-----

1. Install:

        git clone git@github.com/markgollnick/mmd2pdf.git ~/.mmd2pdf
        export PATH=$HOME/.mmd2pdf

2. Use:

        mmd2pdf lab_report.text

3. There is no step 3! (Except turning in that lab report.)


Details
-------

* HTML tags are supported in the output.

* To insert page breaks in the resulting PDF, use:

        <div style=\"page-break-after: always;\"></div>

* Options:

        --math         Enable TeX equation rendering using MathJax
        --keep-html    Retains the intermediate HTML document used to
                       render the PDF.
        --no-pdf       Do not generate PDF, only HTML. For previewing.


License
-------

Boost Software License, Version 1.0: <http://www.boost.org/LICENSE_1_0.txt>


Acknowledgments
---------------

I'd like to thank legobas for creating the original MMD2PDF with AutoITScript,
which can be found here: <https://code.google.com/p/mmd2pdf/> and hope that
he/she doesn't mind my completely hijacking the name. (This started as a
private script on my own machine, but I figured I'd share it in case someone
else found it useful.)
