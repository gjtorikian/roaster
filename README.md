Asynchronously convert a Markdown file into HTML. WOW!


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

## Libraries used

* [marked](https://github.com/chjj/marked) for Markdown conversion
* [emoji-images](https://github.com/henrikjoreteg/emoji-images.js) for emoji conversion