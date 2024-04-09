# File formats

Everyone should be able to download, edit and print their own version without any tech-specific knowledge.
In the end, we want to have a printable document as well as a browser version.
Here are few things that came to mind.

## PDF

PDF is the best format to distribute the final project.
It's not suited to make changes to the document.

## Word processor

Using a WYSIWYG-editor like MS Word, Google Docs or LibreOffice seems to be a good idea, when in fact it isn't.
We don't need complicated file formats like `docx` or any of that kind.
Giving more editor-options to the user is not always good.
It leads to bad formatting and misunderstandings as soon as more people work on one document.

Nevertheless, a word file would be a good candidate for output file format in case someone wants to style the document differently.

## XML

We could define an XML schema or use a predefined one specifically for screenplays.
Editing such a document would be straight forward and a browser could be used to render the result.
Still, the raw source would look rather strange to non-tech people.

## HTML

Using HTML for this kind of project seems to be a good idea.
We could define simple rules on when to use which element and what options.
A little bit of code and CSS and our screenplay would look nice in a browser.

Here's an example: [HTML + CSS screenplay](https://codepen.io/abeeken/pen/yLypvbN)

Transforming the code into PDF would be a little bit of work, but totally doable.

But again, casual LOTR fans would probably dislike the raw format.
They wouldn't be encouraged to support the project.

Instead of using HTML as raw source format, we want HTML to it to be one of the output formats.

## tex

Of course, `tex` is nice, no question.
It suits our use case almost perfectly.

There's a [Screenplay Tex Template](https://www.overleaf.com/latex/templates/screenplay-template/grqmtrnytdhj) available for download and installation.
Have a look at [this document](tex.md) for more information.

In the end, we still want to have a `tex` document as output.
Users can take it from there and edit the document style to their needs.

## Fountain

[Fountain](https://fountain.io) is a plain text markup language for screenwriting.
There's plenty of software available.

This is the format we're going to use.
It's easy and straight-forward to understand.
The raw document format is intuitive to use and almost WYSIWYG due to its structure which resembles the finished product.

### Fountainhead

[Fountainhead](https://packagecontrol.io/packages/Fountainhead) is a contextual screenwriting environment that leverages the speed of Sublime Text and the readability of Fountain, enabling the user to just write.

### afterwriting

[afterwriting](https://afterwriting.com/) is a place where you can play with some screenwriting tools.
You can open screenplays written in Fountain format.
The tool can export files as PDF.
There's an offline and CLI-version available, too.

### Wrap

[Wrap](https://github.com/eprovst/wrap) is a command line tool that is able to convert Fountain and Wrap files into a correctly formatted screen- or stageplay as HTML or PDF.
We use the tool to transform our source files into PDF and HTML.
Find out more on the process [here](wrap.md).
