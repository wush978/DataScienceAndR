<!-- title: markdown2bootstrap.js -->
<!-- subtitle: Converts a markdown document to an html web page using bootstrap styling. -->
# Description

Converts a markdown file to a bootstrap-styled web page with a table of contents. It will figure out sections based on the headings used and calculate section numbers.

# Installing

    $ npm install markdown2bootstrap

# Usage

    $ node_modules/.bin/markdown2bootstrap doc1.md doc2.md ...
    Converted doc1.md to doc1.html
    Converted doc2.md to doc2.html
    ...
    $ cp -a node_modules/markdown2bootstrap/bootstrap ./

Notice that you can convert multiple files by specifying them on the command line.

Now open `doc1.html` in a web browser. You will notice that section numbers are automatically added along with a floating table of contents bootstrap-style. If you want to **turn off section numbering** use the `-n` option:

    $ node_modules/.bin/markdown2bootstrap -n doc.md

The table of contents will still be created.

You can also **turn on a bootstrap page header** by passing `-h`. The header uses a title and a subtitle. You can specify them in the markdown document like this:

        <!-- title: This is a title -->
        <!-- subtitle: This is a subtitle -->

You should at least specify a title to give the webpage a proper html `<title>` tag.

## Output

The converted files are created in the current directory by default with an extension of `.html`. You can specify a different output directory by using the `--outputdir` option:

    $ node_modules/.bin/markdown2bootstrap --outputdir html doc.md
    Converted  doc.md to html/doc.html
