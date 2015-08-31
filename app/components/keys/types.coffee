_ = require 'underscore'
{errors} = require '../../utility'
{covenance, ABC} = require 'covenance'


AbstractKey = ABC
  name: 'AbstractKey'
  proto:
    props:
      symbol: ->
        @constructor.symbol
      keycode: ->
        @constructor.keycode
      shortname: ->
        @constructor.shortname
  klass:
    covenance: covenance.of(
      ['symbol', _.isString],
      ['keycode', _.isNumber],
      ['shortname', _.isString]
    )

class Left extends AbstractKey
  @symbol: "←"
  @keycode: 37
  @shortname: "left"
AbstractKey.implemented_by(Left)

class Up extends AbstractKey
  @symbol: "↑"
  @keycode: 38
  @shortname: "up"
AbstractKey.implemented_by(Up)

class Right extends AbstractKey
  @symbol: "→"
  @keycode: 39
  @shortname: "right"
AbstractKey.implemented_by(Right)

class Down extends AbstractKey
  @symbol: "↓"
  @keycode: 40
  @shortname: "down"
AbstractKey.implemented_by(Down)

class R extends AbstractKey
  @symbol: "R"
  @keycode: 82
  @shortname: "r"
AbstractKey.implemented_by(R)


module.exports =
  LEFT: new Left
  UP: new Up
  RIGHT: new Right
  DOWN: new Down
  R: new R