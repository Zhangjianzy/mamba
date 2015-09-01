_ = require 'underscore'
{errors} = require '../../utility'
{covenance, ABC} = require 'covenance'

AbstractCell = ABC
  name: 'AbstractCell'
  klass:
    covenance: covenance.of ['shortname', _.isString]
  proto:
    props:
      toString: ->
        @constructor.shortname


Item = AbstractCell.implementation class Item
  @shortname: "item"

Void = AbstractCell.implementation class Void
  @shortname: "void"

Wall = AbstractCell.implementation class Wall
  @shortname: "wall"

Snake = AbstractCell.implementation class Snake
  @shortname: "snake"

Collision = AbstractCell.implementation class Collision
  @shortname: "collision"

module.exports =
  ITEM: new Item
  WALL: new Wall
  VOID: new Void
  SNAKE: new Snake
  COLLISION: new Collision
