MMD2PDF
=======

Convert MultiMarkdown-formatted text files to pretty PDF files, easily!

![Screenshot](http://content.screencast.com/users/markgollnick/folders/Jing/media/17e3c770-08d4-4daa-8575-682f7b22c482/mmd2pdf-screen-20130909230931.png)

**Supports basic LaTeX equations!**

E.g., \\( {a}^{2} + {b}^{2} = {c}^{2} \\)

**Supports syntax highlighting!**

    #include <stdio.h>

    int main(void) {
        printf("Hello, world!\n");
        return 0;
    }


Requirements
------------

* MultiMarkdown: <http://fletcherpenney.net/multimarkdown/download/>
* wkhtmltopdf: <https://code.google.com/p/wkhtmltopdf/>
* MathJax (optional - available as a git submodule - used for LaTeX equation
  support): <http://www.mathjax.org/>
* Highlight.js (optional - available as a git submodule - used for source code
  syntax highlighting): <http://softwaremaniacs.org/soft/highlight/en/>


Usage
-----

1. Install:

        git clone git@github.com/markgollnick/mmd2pdf.git ~/.mmd2pdf # Download
        cd ~/.mmd2pdf                                                # Enter
        git submodule update --init                                  # Get Deps
        export PATH=$HOME/.mmd2pdf                                   # Done!

2. Use:

        mmd2pdf lab_report.md

3. There is no step 3! (Except turning in that lab report.)


Details
-------

* HTML tags are supported in the output.

* To insert page breaks in the resulting PDF, use:

        <div style="page-break-after: always;"></div>

* Options:

        --math         Enable rendering using MathJax and Highlight.js
        --keep-html    Retains the intermediate HTML document used to
                       render the PDF.
        --no-pdf       Do not generate PDF, only HTML. For previewing.


License
-------

Boost Software License, Version 1.0: <http://www.boost.org/LICENSE_1_0.txt>


Acknowledgments
---------------

I'd like to thank Legobas for creating the original MMD2PDF with AutoITScript,
(which has a lot more features and customization options than this simple shell
script will ever provide,) which can be found here:
<https://code.google.com/p/mmd2pdf/>
