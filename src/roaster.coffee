#!/usr/bin/env coffee

Fs = require 'fs'
Path = require 'path'
marked = require 'marked'
emoji = require 'emoji-images'
taskLists = require 'task-lists'
cheerio = require 'cheerio'

emojiFolder = Path.join(Path.dirname( require.resolve('emoji-images') ), "pngs")

module.exports = (file, opts, callback) ->
  options =
    isFile: false
    header: '<h<%= level %>><a name="<%= anchor %>" class="anchor" href="#<%= anchor %>"><span class="octicon octicon-link"></span></a><%= header %></h<%= level %>>'
    anchorMin: 1

  conversion = (data) ->
    # turn MD to HTML
    mdToHtml = marked(data)
    # turn emoji in HTML to images
    emojified = emoji(mdToHtml, emojiFolder, 20)

    # emoji-images is too aggressive; let's replace images in monospace tags with the actual emoji text
    $ = cheerio.load(emojified)
    $('pre img').each (index, element) ->
      $(this).replaceWith $(this).attr('title')
    $('code img').each (index, element) ->
      $(this).replaceWith $(this).attr('title')

    # turn - [ ] in HTML to tasklists
    contents = taskLists($.html())

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
