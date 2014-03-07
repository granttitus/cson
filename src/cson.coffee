parser = require('./grammar').parser

parse = (cson) ->
    try
        obj = parser.parse cson


module.exports.parse = parse
