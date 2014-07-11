roaster = require '../lib/roaster'
Path = require 'path'
Fs = require 'fs'
cheerio = require 'cheerio'

fixtures_dir = Path.join(__dirname, "fixtures")
YAML_fixtures_before_dir = Path.join(fixtures_dir, "yaml", "before")
YAML_fixtures_after_dir = Path.join(fixtures_dir, "yaml", "after")

describe "roaster", ->

  describe "options", ->
    describe "passing options.isFile = true", ->
      it "returns a rendered file", ->
        callback = jasmine.createSpy()
        roaster Path.join(fixtures_dir, "markdown.md"), {isFile: true}, callback

        waitsFor ->
          callback.callCount > 0

        runs ->
          [err, contents] = callback.mostRecentCall.args
          expect(err).toBeNull()
          expect(contents).toContain '<code class="lang-bash">'
    describe "not passing options.isFile", ->
      it "returns a rendered file", ->
        contents = Fs.readFileSync(Path.join(fixtures_dir, "markdown.md"), {encoding: "utf8"})
        roaster contents, (err, contents) ->
          expect(err).toBeNull()
          expect(contents).toContain '<code class="lang-bash">'

  describe "yaml frontmatter", ->
    it "properly converts array_data", ->
      callback = jasmine.createSpy()
      roaster Path.join(YAML_fixtures_before_dir, "array_data.md"), {isFile: true}, callback

      waitsFor ->
        callback.callCount > 0

      runs ->
        [err, contents] = callback.mostRecentCall.args
        expect(err).toBeNull()
        after = Fs.readFileSync(Path.join(YAML_fixtures_after_dir, "array_data.text"), 'utf8')
        expect(contents).toEqual after

    it "properly converts basic_with_markdown", ->
      callback = jasmine.createSpy()
      roaster Path.join(YAML_fixtures_before_dir, "basic_with_markdown.md"), {isFile: true}, callback

      waitsFor ->
        callback.callCount > 0

      runs ->
        [err, contents] = callback.mostRecentCall.args
        expect(err).toBeNull()
        after = Fs.readFileSync(Path.join(YAML_fixtures_after_dir, "basic_with_markdown.text"), 'utf8')
        expect(contents).toEqual after

    it "properly converts basic", ->
      callback = jasmine.createSpy()
      roaster Path.join(YAML_fixtures_before_dir, "basic.md"), {isFile: true}, callback

      waitsFor ->
        callback.callCount > 0

      runs ->
        [err, contents] = callback.mostRecentCall.args
        expect(err).toBeNull()
        after = Fs.readFileSync(Path.join(YAML_fixtures_after_dir, "basic.text"), 'utf8')
        expect(contents).toEqual after

    it "properly converts nested_yaml", ->
      callback = jasmine.createSpy()
      roaster Path.join(YAML_fixtures_before_dir, "nested_yaml.md"), {isFile: true}, callback

      waitsFor ->
        callback.callCount > 0

      runs ->
        [err, contents] = callback.mostRecentCall.args
        expect(err).toBeNull()
        after = Fs.readFileSync(Path.join(YAML_fixtures_after_dir, "nested_yaml.text"), 'utf8')
        expect(contents).toEqual after

    it "properly converts no_yaml", ->
      callback = jasmine.createSpy()
      roaster Path.join(YAML_fixtures_before_dir, "no_yaml.md"), {isFile: true}, callback

      waitsFor ->
        callback.callCount > 0

      runs ->
        [err, contents] = callback.mostRecentCall.args
        expect(err).toBeNull()
        after = Fs.readFileSync(Path.join(YAML_fixtures_after_dir, "no_yaml.text"), 'utf8')
        expect(contents).toEqual after

    it "properly converts not_really_yaml", ->
      callback = jasmine.createSpy()
      roaster Path.join(YAML_fixtures_before_dir, "not_really_yaml.md"), {isFile: true}, callback

      waitsFor ->
        callback.callCount > 0

      runs ->
        [err, contents] = callback.mostRecentCall.args
        expect(err).toBeNull()
        after = Fs.readFileSync(Path.join(YAML_fixtures_after_dir, "not_really_yaml.text"), 'utf8')
        expect(contents).toEqual after

    it "properly converts parse_error", ->
      callback = jasmine.createSpy()
      roaster Path.join(YAML_fixtures_before_dir, "parse_error.md"), {isFile: true}, callback

      waitsFor ->
        callback.callCount > 0

      runs ->
        [err, contents] = callback.mostRecentCall.args
        expect(err).toBeNull()
        after = Fs.readFileSync(Path.join(YAML_fixtures_after_dir, "parse_error.text"), 'utf8')
        expect(contents).toEqual after

    it "properly converts symbol_data", ->
      callback = jasmine.createSpy()
      roaster Path.join(YAML_fixtures_before_dir, "symbol_data.md"), {isFile: true}, callback

      waitsFor ->
        callback.callCount > 0

      runs ->
        [err, contents] = callback.mostRecentCall.args
        expect(err).toBeNull()
        after = Fs.readFileSync(Path.join(YAML_fixtures_after_dir, "symbol_data.text"), 'utf8')
        expect(contents).toEqual after

    it "property converts just front-matter with no other content", ->
      callback = jasmine.createSpy()
      roaster Path.join(YAML_fixtures_before_dir, "only_yaml.md"), {isFile: true}, callback

      waitsFor ->
        callback.callCount > 0

      runs ->
        [err, contents] = callback.mostRecentCall.args
        expect(err).toBeNull()
        after = Fs.readFileSync(Path.join(YAML_fixtures_after_dir, "only_yaml.text"), 'utf8')
        expect(contents).toEqual after

  describe "emoji", ->
    it "returns emoji it knows", ->
      callback = jasmine.createSpy()
      roaster Path.join(fixtures_dir, "emoji.md"), {isFile: true}, callback

      waitsFor ->
        callback.callCount > 0

      runs ->
        [err, contents] = callback.mostRecentCall.args
        expect(err).toBeNull()

        $ = cheerio.load(contents)
        expect($("p img").length).toBe 3

        expect($('p img[title=":trollface:"]').length).toBe 1
        expect($('p img[title=":trollface:"]').attr("class")).toEqual "emoji"
        expect($('p img[title=":trollface:"]').attr("alt")).toEqual "trollface"
        expect($('p img[title=":trollface:"]').attr("src")).toMatch /.*trollface\.png$/

        expect($('p img[title=":shipit:"]').length).toBe 1
        expect($('p img[title=":shipit:"]').attr("class")).toEqual "emoji"
        expect($('p img[title=":shipit:"]').attr("alt")).toEqual "shipit"
        expect($('p img[title=":shipit:"]').attr("src")).toMatch /.*shipit\.png$/

        expect($('p img[title=":smiley:"]').length).toBe 1
        expect($('p img[title=":smiley:"]').attr("class")).toEqual "emoji"
        expect($('p img[title=":smiley:"]').attr("alt")).toEqual "smiley"
        expect($('p img[title=":smiley:"]').attr("src")).toMatch /.*smiley\.png$/
    it "can sanitize and return", ->
      callback = jasmine.createSpy()
      roaster Path.join(fixtures_dir, "emoji.md"), {isFile: true, sanitize:true}, callback

      waitsFor ->
        callback.callCount > 0

      runs ->
        [err, contents] = callback.mostRecentCall.args
        expect(err).toBeNull()

        $ = cheerio.load(contents)
        expect($("p img").length).toBe 3

        expect($('p img[title=":trollface:"]').length).toBe 1
        expect($('p img[title=":trollface:"]').attr("class")).toEqual "emoji"
        expect($('p img[title=":trollface:"]').attr("alt")).toEqual "trollface"
        expect($('p img[title=":trollface:"]').attr("src")).toMatch /.*trollface\.png$/

        expect($('p img[title=":shipit:"]').length).toBe 1
        expect($('p img[title=":shipit:"]').attr("class")).toEqual "emoji"
        expect($('p img[title=":shipit:"]').attr("alt")).toEqual "shipit"
        expect($('p img[title=":shipit:"]').attr("src")).toMatch /.*shipit\.png$/

        expect($('p img[title=":smiley:"]').length).toBe 1
        expect($('p img[title=":smiley:"]').attr("class")).toEqual "emoji"
        expect($('p img[title=":smiley:"]').attr("alt")).toEqual "smiley"
        expect($('p img[title=":smiley:"]').attr("src")).toMatch /.*smiley\.png$/
    it "does nothing to unknown emoji", ->
      roaster ":lala:", (err, contents) ->
        expect(err).toBeNull()
        expect(contents).toEqual '<p>:lala:</p>\n'
    it "does not mess up coded emoji", ->
      callback = jasmine.createSpy()
      roaster Path.join(fixtures_dir, "emoji_bad.md"), {isFile: true}, callback

      waitsFor ->
        callback.callCount > 0

      runs ->
        [err, contents] = callback.mostRecentCall.args

        expect(err).toBeNull()
        expect(contents).toEqual '<pre><code class="lang-ruby">not :trollface:\n</code></pre>\n<p>wow <code>that is nice :smiley:</code></p>\n<p><code>:laughing:</code></p>\n<p><code>:lipstick:</code></p>\n<pre><code>:laughing:\n</code></pre><pre><code>:lipstick:\n</code></pre>'

  # describe "headers", ->
  #   [toc, result, resultShort] = []

  #   beforeEach ->
  #     toc = Fs.readFileSync(Path.join(fixtures_dir, "toc.md"), {encoding: "utf8"})
  #     result = Fs.readFileSync(Path.join(fixtures_dir, "toc_normal_result.html"), {encoding: "utf8"})
  #     resultShort = Fs.readFileSync(Path.join(fixtures_dir, "toc_short_result.html"), {encoding: "utf8"})

  #   it "adds anchors to all headings", ->
  #     roaster toc, (err, contents) ->
  #       expect(err).toBeNull()
  #       expect(contents.replace(/^\s+|\s+$/g, '')).toContain result.replace(/\s+$/g, '')

  #   it "truncates anchors on headings, due to options", ->
  #     roaster toc, {anchorMin: 3, anchorMax: 4}, (err, contents) ->
  #       expect(err).toBeNull()
  #       expect(contents.replace(/^\s+|\s+$/g, '')).toContain resultShort.replace(/\s+$/g, '')
