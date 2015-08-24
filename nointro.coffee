url = require 'url'
path = require 'path'
fetch = require 'isomorphic-fetch'
JSZip = require 'jszip'

getURL = (rom, date) ->
  date ?= '2015-03-03'
  collection = "No-Intro-Collection_#{date}"
  url.format
    protocol: 'http'
    hostname: 'ia800500.us.archive.org'
    pathname: "zipview.php"
    query:
      zip: "/33/items/#{collection}/#{rom.nointro_console}.zip"
      file: "#{rom.nointro_console}/#{rom.nointro_name}.zip"

getROM = (rom) ->
  fetch getURL rom
  .then (res) ->
    res.arrayBuffer()
  .then (data) ->
    zip = new JSZip data
    file = zip.file rom.file_name
    if file is null
      throw new Error 'Cannot find rom.'
    file.asArrayBuffer()

hasROM = (rom) -> #TODO: intelligent hasROM
  new Promise (resolve, reject) ->
    resolve true

module.exports = {getURL, getROM, hasROM}
