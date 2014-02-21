Asynchronously convert a Markdown file into HTML. WOW!

You can specify either the contents of a file, or, the path to a file to read.

## Usage

```javascript
var roaster = require("roaster");
var fs = require("fs");
var options = {}

roaster("./markdown.md", options, function(err, contents) {
	fs.writeFileSync("./markdown.html", contents, "utf8");
});
```

## Options

The second parameter, `options`, is optional. Any options defined
here are passed to the dependent libraries for use in their own systems.

If you pass `options.isFile`, the first parameter is assumed to be a file path.
By default, this is `false`, which means that the first parameter is an
actual string of Markdown.

## Libraries used

* [marked](https://github.com/chjj/marked) for Markdown conversion
* [emoji-images](https://github.com/henrikjoreteg/emoji-images.js) for emoji conversion
