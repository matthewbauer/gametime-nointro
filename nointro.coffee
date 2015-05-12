url = require 'url'
fs = require 'fs'
request = require 'request'
unzip = require 'unzip'
streamBuffers = require 'stream-buffers'

module.exports.getROM = (rom, cb) ->
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
  request(romURL).pipe(unzip.Parse()).on 'entry', (entry) ->
    if entry.type is 'File'
      writableStream = new streamBuffers.WritableStreamBuffer()
      entry.pipe(writableStream).on 'close', ->
        cb writableStream.getContents(), entry.uncompressedSize
    else
      entry.autodrain()

module.exports.hasROM = (rom, cb) ->
  cb true
