#!/usr/bin/env coffee

Fs = require 'fs'
Path = require 'path'
marked = require 'marked'
emoji = require 'emoji-images'
taskLists = require 'task-lists'

emoji_folder = Path.dirname( require.resolve('emoji-images') ) + "/pngs"

module.exports = (file, options, callback) ->
    conversion = (data) ->
        emojified = emoji(data, emoji_folder, 20)
        mdToHtml = marked(emojified)
        contents = taskLists(mdToHtml)

    marked.setOptions(options)

    if options.isFile
        Fs.readFile(file, "utf8", (err, data) => 
            callback(null, conversion(data))
        )
    else
        callback(null, conversion(file))