roaster = require '../lib/roaster'
Path = require 'path'

fixtures_dir = Path.join(__dirname, "fixtures")

describe "roaster", ->

  describe "options", ->
    describe "passing options.isFile = true", ->
      it "returns a rendered file", ->
        roaster Path.join(fixtures_dir, "markdown.md"), {isFile: true}, (err, contents) ->
          expect(err).toBeNull()
          expect(contents).toContain '<code class="lang-bash">'


  describe "emoji", ->
    it "returns null", ->
