#!/usr/bin/env coffee

Fs = require 'fs'
Path = require 'path'
marked = require 'marked'
emoji = require 'emoji-images'
taskLists = require 'task-lists'

emojiFolder = Path.dirname( require.resolve('emoji-images') ) + "/pngs"

defaultOptions =
  isFile: false

module.exports = (file, opts, callback) ->
    conversion = (data) ->
        emojified = emoji(data, emojiFolder, 20)
        mdToHtml = marked(emojified)
        contents = taskLists(mdToHtml)

    options = {}
    if typeof opts is 'function'
      [options, callback] = [defaultOptions, opts]
    else
      for key of opts
        options[key] = opts[key]

    marked.setOptions(options)

    if options.isFile
        Fs.readFile(file, "utf8", (err, data) =>
            callback(null, conversion(data))
        )
    else
        callback(null, conversion(file))
