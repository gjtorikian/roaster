#!/usr/bin/env coffee

Fs = require 'fs'
Path = require 'path'
marked = require 'marked'
emoji = require 'emoji-images'
taskLists = require 'task-lists'

emojiFolder = Path.join(Path.dirname( require.resolve('emoji-images') ), "pngs")

module.exports = (file, opts, callback) ->
  options =
    isFile: false
    header: '<h<%= level %>><a name="<%= anchor %>" class="anchor" href="#<%= anchor %>"><span class="octicon octicon-link"></span></a><%= header %></h<%= level %>>'
    anchorMin: 1

  conversion = (data) ->
    mdToHtml = marked(data)
    emojified = emoji(mdToHtml, emojiFolder, 20).replace(/\\</g, "&lt;")
    contents = taskLists(emojified)

  if typeof opts is 'function'
    callback = opts
  else
    for key of opts
      options[key] = opts[key]

  marked.setOptions(options)

  if options.isFile
    Fs.readFile file, "utf8", (err, data) =>
      if err
        callback(err, null)
      else
        callback(null, conversion(data))
  else
    callback(null, conversion(file))
