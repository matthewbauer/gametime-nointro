url = require 'url'
path = require 'path'
fetch = require 'hctef'
JSZip = require 'jszip'

consoles =
  '32X': 'Sega - 32X'
  '5200': 'Atari - 5200'
  '7800': 'Atari - 7800'
  'ColecoVision': 'Coleco - ColecoVision'
  'FDS': 'Nintendo - Famicom Disk System'
  'GB': 'Nintendo - Game Boy'
  'GBC': 'Nintendo - Game Boy Color'
  'GBA': 'Nintendo - Game Boy Advance'
  'GG': 'Sega - Game Gear'
  'Jaguar': 'Atari - Jaguar'
  'Lynx': 'Atari - Lynx'
  'MD': 'Sega - Mega Drive - Genesis'
  'N64': 'Nintendo - Nintendo 64'
  'NES': 'Nintendo - Nintendo Entertainment System'
  'NGP': 'SNK - Neo Geo Pocket'
  'NGPC': 'SNK - Neo Geo Pocket Color'
  'PCE': 'NEC - PCE Engine - TurboGrafx 16'
  'SG1000': 'Sega - SG 1000'
  'SMS': 'Sega - Master System - Mark III'
  'SNES': 'Nintendo - Super Nintendo Entertainment System'
  'SuperGrafx': 'NEC - Super Grafx'
  'VB': 'Nintendo - Virtual Boy'
  'Vectrex': 'GCE - Vectrex'
  'WonderSwan': 'Bandai - WonderSwan'
  'WonderSwan Color': 'Bandai - WonderSwan Color'
  # 'Saturn': 'Saturn'
  'PCECD': 'NEC - PC Engine - TurboGrafx 16'
  # 'PSP': 'PSP'
  # 'NDS': 'NDS'
  # '2600': '2600'
  'Odyssey2': 'Magnavox - Odyssey2'
  # 'Intellivision' : 'Intellivision'

getURL = (game, date) ->
  date ?= '2015-03-03'
  collection = "No-Intro-Collection_#{date}"
  console = consoles[game.systemShortName]
  'https://crossorigin.herokuapp.com/' + url.format
    protocol: 'https'
    hostname: 'ia800500.us.archive.org'
    pathname: "zipview.php"
    query:
      zip: "/33/items/#{collection}/#{console}.zip"
      file: "#{console}/#{game.romExtensionlessFileName}.zip"

getROM = (game) ->
  fetch getURL game
  .then (res) ->
    res.arrayBuffer()
  .then (data) ->
    zip = new JSZip data
    file = zip.file game.romFileName
    if file is null
      throw new Error 'Cannot find rom.'
    file.asArrayBuffer()

hasROM = (rom) -> #TODO: intelligent hasROM
  new Promise (resolve, reject) ->
    resolve true

module.exports = {getURL, getROM, hasROM}
