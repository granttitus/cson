# CSON [![Build Status](https://travis-ci.org/stronglink/cson.png?branch=master)](https://travis-ci.org/stronglink/cson)
CoffeeScript flavored JSON

## What's Different?
Parsing CSON using CoffeeScript's `eval` function isn't ideal. Instead, we use [Jison](http://zaach.github.io/jison/).

### Example
```coffeescript
{
    name: 'cson'
    description: 'CoffeeScript flavored JSON'
 
    dependencies:
        jison: '0.0.0'
 
    devDependencies:
        chai: '0.0.0'
}
```
