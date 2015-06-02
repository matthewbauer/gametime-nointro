url = require 'url'
fs = require 'fs'
path = require 'path'
request = require 'request'
unzip = require 'unzip'
streamBuffers = require 'stream-buffers'

date = '2015-03-03'
module.exports.getROM = (rom) ->
  new Promise (resolve, reject) ->
    request url.format
      protocol: 'https'
      hostname: 'archive.org'
      pathname: path.join 'download',
        "No-Intro-Collection_#{date}",
        "#{rom.nointro_console}.zip",
        "#{rom.nointro_console}%2F#{rom.nointro_name}.zip"
    .pipe unzip.Parse()
    .on 'entry', (entry) ->
      if entry.type is 'File'
        writableStream = new streamBuffers.WritableStreamBuffer()
        entry
        .pipe writableStream
        .on 'close', ->
          resolve writableStream.getContents()
      else
        entry.autodrain()
    .on 'close', reject

module.exports.hasROM = (rom, cb) ->
  new Promise (resolve, reject) ->
    resolve true
