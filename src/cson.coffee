parser = require('./grammar').parser

parseSync = (cson) ->
    parser.parse cson

module.exports.parseSync = parseSync
