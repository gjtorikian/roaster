#!/usr/bin/env coffee

Fs = require 'fs'
Path = require 'path'
marked = require 'marked'
emoji = require 'emoji-images'

emoji_folder = Path.dirname( require.resolve('emoji-images') ) + "/pngs"

module.exports = (file, options, callback) ->
    marked.setOptions(options)

    Fs.readFile(file, "utf8", (err, data) => 
        emojified = emoji(data, emoji_folder, 20)
        mdToHtml = marked(emojified)
        callback(null, mdToHtml)
    )