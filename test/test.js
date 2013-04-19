require('coffee-script');
var roaster = require("../src/roaster");
var fs = require("fs");

roaster("./markdown.md", {}, function(err, contents) {
	fs.writeFileSync("./markdown.html", contents, "utf8");
});