url = require 'url'
fs = require 'fs'
request = require 'request'
unzip = require 'unzip'
streamBuffers = require 'stream-buffers'

module.exports.getROM = (rom) ->
  date = '2015-03-03'
  romURL = url.format
    protocol: 'https'
    hostname: 'archive.org'
    pathname: [
      'download'
      "No-Intro-Collection_#{date}"
      "#{rom.nointro_console}.zip"
      "#{rom.nointro_console}%2F#{rom.nointro_name}.zip"
    ].join '/'
  new Promise (resolve, reject) ->
    request romURL
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
    resolve(true)
