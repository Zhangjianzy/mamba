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


class Item extends AbstractCell
  @shortname: "item"
AbstractCell.implemented_by Item


class Void extends AbstractCell
  @shortname: "void"
AbstractCell.implemented_by Void


class Wall extends AbstractCell
  @shortname: "wall"
AbstractCell.implemented_by Wall


class Snake extends AbstractCell
  @shortname: "snake"
AbstractCell.implemented_by Snake


class Collision extends AbstractCell
  @shortname: "collision"
AbstractCell.implemented_by Collision


module.exports =
  ITEM: new Item
  WALL: new Wall
  VOID: new Void
  SNAKE: new Snake
  COLLISION: new Collision
