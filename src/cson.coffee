parser = require('./grammar').parser

parse = (cson) ->
    try
        json = parser.parse cson
        JSON.parse json

module.exports.parse = parse
