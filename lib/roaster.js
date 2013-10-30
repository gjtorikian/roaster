(function() {
  var Fs, Path, emoji, emojiFolder, marked, options, taskLists, toc;

  Fs = require('fs');

  Path = require('path');

  marked = require('marked');

  emoji = require('emoji-images');

  taskLists = require('task-lists');

  toc = require('toc');

  emojiFolder = Path.join(Path.dirname(require.resolve('emoji-images')), "pngs");

  options = {
    isFile: false,
    header: '<h<%= level %>><a name="<%= anchor %>" class="anchor" href="#<%= anchor %>"><span class="octicon octicon-link"></span></a><%= header %></h<%= level %>>'
  };

  module.exports = function(file, opts, callback) {
    var conversion, key,
      _this = this;
    conversion = function(data) {
      var contents, emojified, mdToHtml;
      emojified = emoji(data, emojiFolder, 20).replace(/\\</g, "&lt;");
      mdToHtml = marked(emojified);
      contents = taskLists(mdToHtml);
      return contents = toc.process(contents, options);
    };
    if (typeof opts === 'function') {
      callback = opts;
    } else {
      for (key in opts) {
        options[key] = opts[key];
      }
    }
    marked.setOptions(options);
    if (options.isFile) {
      return Fs.readFile(file, "utf8", function(err, data) {
        return callback(err, conversion(data));
      });
    } else {
      return callback(null, conversion(file));
    }
  };

}).call(this);
