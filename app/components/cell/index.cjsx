React = require 'react'
cells = require './abstract'
{LEVEL} = require '../../settings'
Immutable = require 'immutable'

_ = require 'underscore'

Cell = React.createClass

  propTypes:
    content: React.PropTypes.oneOf(_.values cells).isRequired

  statics: _.extend {}, cells
  , classmap: Immutable.Map [
      [
        cells.ITEM
        'item-cell'
      ]
      [
        cells.VOID
        'void-cell'
      ]
      [
        cells.WALL
        'wall-cell'
      ]
      [
        cells.SNAKE
        'snake-cell'
      ]
      [
        cells.COLLISION
        'collision-cell'
      ]
    ]

  render: ->
    <div className="#{@constructor.classmap.get(@props.content)}"></div>


module.exports = Cell