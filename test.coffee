should = require 'should'
nointro = require './nointro'
request = require 'request'
fs = require 'fs'

roms = [
  releaseTitleName: 'Super Mario World'
  releaseCoverFront: 'http://img.gamefaqs.net/box/6/2/5/14625_front.jpg'
  releaseCoverBack: 'http://img.gamefaqs.net/box/6/2/5/14625_back.jpg'
  releaseDescription: 'Mario\'s off on his biggest adventure ever, and this time he\'s brought along a friend. Yoshi the dinosaur teams up with Mario to battle Bowser, who has kidnapped Princess Toadstool once again. Guide Mario and Yoshi through nine peril-filled worlds to the final showdown in Bowser\'s castle. Use Mario\'s new powers and Yoshi\'s voracious monster-gobbling appetite as you explore 96 levels filled with dangerous new monsters and traps. Climb mountains and cross rivers, and descend into subterranean depths. Destroy the seven Koopa castles and find keys to gain entrance to hidden levels. Discover more warps and thrilling bonus worlds than ever before!'
  releaseDeveloper: 'Nintendo'
  releaseGenre: 'Action,Platformer,2D'
  releaseDate: 'Aug 13, 1991'
  releaseReferenceURL: 'http://www.gamefaqs.com/snes/519824-super-mario-world'
  releaseReferenceImageURL: 'http://www.gamefaqs.com/snes/519824-super-mario-world/images/box-28403'
  romHashCRC: 'B19ED489'
  romHashMD5: 'CDD3C8C37322978CA8669B34BC89C804'
  romHashSHA1: '6B47BB75D16514B6A476AA0C73A683A2A4C18765'
  romSize: 524288
  romFileName: 'Super Mario World (USA).sfc'
  romExtensionlessFileName: 'Super Mario World (USA)'
  romDumpSource: 'No-Intro'
  regionName: 'USA'
  systemName: 'Nintendo Super Nintendo Entertainment System'
  systemShortName: 'SNES'
]

for rom in roms
  do (rom) ->
    describe "#{rom.releaseTitleName}", ->
      url = nointro.getURL rom
      console.log(url)
      it "url should resolve to 200", (done) ->
        request url, (err, resp, body) ->
          should.not.exist err
          resp.statusCode.should.equal 200
          body.should.exist
          done()
      it "should be able to find rom in zip", (done) ->
        @timeout 10000
        nointro.getROM rom
        .then (buffer) ->
          should.exist buffer
        .then done, done
