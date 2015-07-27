should = require 'should'
nointro = require './nointro'
request = require 'request'
fs = require 'fs'

roms = [
  nointro_name: 'Super Mario World (USA)'
  file_name: 'Super Mario World (USA).sfc'
  nointro_console: 'Nintendo - Super Nintendo Entertainment System'
]

for rom in roms
  do (rom) ->
    describe "#{rom.nointro_name}", ->
      url = nointro.getURL rom
      it "url should resolve to 200", (done) ->
        request url, (err, resp, body) ->
          should.not.exist err
          resp.statusCode.should.equal 200
          body.should.exist
          done()
      it "should be able to find rom in zip", (done) ->
        nointro.getROM rom
        .then (buffer) ->
          should.exist buffer
          done()
