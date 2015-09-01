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

Left = AbstractKey.implementation class Left
  @symbol: "←"
  @keycode: 37
  @shortname: "left"

Up = AbstractKey.implementation class Up
  @symbol: "↑"
  @keycode: 38
  @shortname: "up"

Right = AbstractKey.implementation class Right
  @symbol: "→"
  @keycode: 39
  @shortname: "right"

Down = AbstractKey.implementation class Down
  @symbol: "↓"
  @keycode: 40
  @shortname: "down"

R = AbstractKey.implementation class R
  @symbol: "R"
  @keycode: 82
  @shortname: "r"


module.exports =
  LEFT: new Left
  UP: new Up
  RIGHT: new Right
  DOWN: new Down
  R: new R