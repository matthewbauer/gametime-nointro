url = require 'url'
path = require 'path'
request = require 'request'
JSZip = require 'jszip'

getURL = (rom, date) ->
  date ?= '2015-03-03'
  url.format
    protocol: 'https'
    hostname: 'archive.org'
    pathname: path.join 'download',
      "No-Intro-Collection_#{date}",
      "#{rom.nointro_console}.zip",
      "#{rom.nointro_console}%2F#{rom.nointro_name}.zip"

getROM = (rom) ->
  new Promise (resolve, reject) ->
    request
      url: getURL rom
      encoding: null
    , (err, resp, body) ->
      if err or resp.statusCode != 200
        reject err
        return
      zip = new JSZip body
      file = zip.file rom.file_name
      if file is null
        reject()
        return
      resolve file.asArrayBuffer()

hasROM = (rom, cb) -> #TODO: intelligent hasROM
  new Promise (resolve, reject) ->
    resolve true

module.exports = {getURL, getROM, hasROM}
