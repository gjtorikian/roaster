Asynchronously convert a Markdown file into HTML. WOW!

You can specify either the contents of a file, or, the path to a file to read.
## Usage

```javascript
require('coffee-script');
var roaster = require("../src/roaster");
var fs = require("fs");
var options = {}

roaster("./markdown.md", options, function(err, contents) {
	fs.writeFileSync("./markdown.html", contents, "utf8");
});
```

## Options

* All options are passed to `marked` for rendering
* If you pass `options.isFile`, the first parameter is assumed to be a file path

## Libraries used

* [marked](https://github.com/chjj/marked) for Markdown conversion
* [emoji-images](https://github.com/henrikjoreteg/emoji-images.js) for emoji conversion