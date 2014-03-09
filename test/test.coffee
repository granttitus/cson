fs = require 'fs'
expect = require('chai').expect
cson = require "#{__dirname}/../src"

load = (file) ->
    fs.readFileSync(file).toString()

describe 'strings', ->

    it 'should compile a key with double quotes', ->
        input = '{
                    "key": "value"
                }'
        json = '{
                    "key": "value"
                }'

        expect(cson.parse input).to.be.eql JSON.parse(json)
    
    it 'should compile a key with single quotes', ->
        input = '{
                    \'key\': "value"
                }'
        json = '{
                    "key": "value"
                }'

        expect(cson.parse input).to.be.eql JSON.parse(json)

    it 'should compile a key with no quotes', ->
        input = '{
                    key: "value"
                }'
        json = '{
                    "key": "value"
                }'

        expect(cson.parse input).to.be.eql JSON.parse(json)
    
    it 'should compile a key and number value', ->
        input = '{
                    key: 25
                }'
        json = '{
                    "key": 25
                }'

        expect(cson.parse input).to.be.eql JSON.parse(json)

    it 'should compile multiple pairs', ->
        input = '{
                    firstName: "George"
                    lastName: "Purdell"
                    age: 21
                }'
        json = '{
                    "firstName": "George",
                    "lastName": "Purdell",
                    "age": 21
                }'

        expect(cson.parse input).to.be.eql JSON.parse(json)
    
    it 'should compile valid symbol keys', ->
        input = '{
                    $: "jQuery"
                    _: "underscore"
                }'
        json = '{
                    "$": "jQuery",
                    "_": "underscore"
                }'
        expect(cson.parse input).to.be.eql JSON.parse(json)


describe 'arrays', ->
    
    it 'should compile an array', ->

        input = '{
                    numbers: [1, 2, 3, 4]
                }'
        json = '{
                    "numbers": [1, 2, 3, 4]
                }'

        expect(cson.parse input).to.be.eql JSON.parse(json)

    it 'should compile just an array', ->

        input = '[1, 2, 3, 4]'
        json = '[1, 2, 3, 4]'

        expect(cson.parse input).to.be.eql JSON.parse(json)

    it 'should compile a "sparse" array', ->

        input = '{
                    array:
                    [
                        \'a\'\n
                        \'b\'\n
                        \'c\'\n
                    ]
                }'
        json = '{
                    "array":
                    [
                        "a",
                        "b",
                        "c"
                    ]
                }'

        expect(cson.parse input).to.be.eql JSON.parse(json)

    it 'should compile a "squished" array ', ->

        input = '{
                    array: [ \'a\'\n
                        \'b\'\n
                        \'c\' ]
                }'
        json = '{
                    "array":
                    [
                        "a",
                        "b",
                        "c"
                    ]
                }'
    
        expect(cson.parse input).to.be.eql JSON.parse(json)

describe 'nested objects', ->
    
    it 'should compile a singly nested object', ->
        input = '{
                    pizza: {
                        toppings: ["cheese", "veggies"]
                        cost: 12
                    }
                }'
        json = '{
                    "pizza": {
                        "toppings": ["cheese", "veggies"],
                        "cost": 12
                    }
                }'
        
        expect(cson.parse input).to.be.eql JSON.parse(json)
