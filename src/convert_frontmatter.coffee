YAML = require 'js-yaml'
_    = require 'underscore'

# converts YAML frontmatter into a table
module.exports = (content) =>
  process_yaml = (data) ->
    th_row = []
    tb_row = []
    tr_row = []

    # checks for whether the YAML is an array, including an array of Hashes
    is_array = _.isArray data
    is_hash_array = _.any _.keys(data), (d) -> _.isObject(d)

    if is_hash_array && !is_array
      _.each _.keys(data[0]), (header) -> th_row.push table_format("TH", header)
    # we can skip simple arrays, because they'll be represented as <table>s
    else if !is_array
      _.each _.keys(data), (header) -> th_row.push table_format("TH", header)

    th = if _.isEmpty th_row then "" else table_format("THEAD", table_format("TR", th_row))

    elements = if is_array then data else _.values data

    _.each elements, (value) ->
      # TODO: js-yaml messes with dates! 2012-09-11 -> Mon Sep 10 2012 17:00:00 GMT-0700 (PDT). fix upstream?
      if _.isArray(value) || (_.isObject(value) && !_.isDate(value))
        tb_row.push table_format("TD", process_yaml(value))
      else
        tb_row.push table_format("TD", value)

    tr_row.push table_format("TR", tb_row) unless _.isEmpty tb_row
    tb = table_format("TB", tr_row)

    table_format("TBL", th, tb)

  table_format = (str, values...) ->
    # patterns for table elements
    switch str
      when "TBL"
        return "<table>#{values[0]}#{values[1]}</table>"
      when "THEAD"
        return "\n  <thead>#{values[0]}</thead>"
      when "TB"
        return "\n  <tbody>#{values[0]}</tbody>\n"
      when "TR"
        return "\n  <tr>#{values[0].join("")}</tr>\n  "
      when "TH"
        return "\n  <th>#{values[0]}</th>\n  "
      when "TD"
        return "\n  <td><div>#{values[0]}</div></td>\n  "

  try
    if items = content.match /^(-{3}(?:\n|\r)([\w\W]+?)-{3})?([\w\W]*)*/
      body = items[3] ? ''

      data = YAML.load(items[2])

      # avoids content that's not YAML
      return [null, content] unless _.isObject(data)

      # the sub adds an id to only the first table element (in case of nested tables)
      frontmatter = process_yaml(data).replace(/<table/, "<table data-table-type=\"yaml-metadata\"").replace(/^\s*$/gm, '')

      return [frontmatter, body]
    else
      return [null, content]
  catch YAMLException
    frontmatter = "<pre lang=\"yaml\"><code>\n#{items[1]}</code></pre>"

    return [frontmatter, body]
