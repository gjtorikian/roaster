require('coffee-script');
var roaster = require("../src/roaster");
var fs = require("fs");

var options = {};
options.isFile = true;

roaster("./markdown.md", options, function(err, contents) {
    fs.writeFileSync("./markdown.html", contents, "utf8");
});