React = require 'react'
Immutable = require 'immutable'

Keys = require './abstract'
Key = require './key'
Deactivates = require './deactivates'
{PressedKeys} = require '../../stores'


ArrowKeys = React.createClass

  mixins: [Deactivates]

  componentWillMount: ->
    @setState active_by_key: Immutable.Map [
     [Keys.LEFT, false]
     [Keys.UP, false]
     [Keys.RIGHT, false]
     [Keys.DOWN, false]
    ]

    PressedKeys.add_change_listener ({keycode}) =>
      @_on_change({keycode})

  shouldComponentUpdate: (__, next_state) ->
    next_state.active_by_key isnt @state.active_by_key

  _on_change: ({keycode}) ->
    active_by_key = @state.active_by_key.withMutations (mutable_keys) ->
      mutable_keys.forEach (active, key) ->
        mutable_keys.set(key, key.keycode() is keycode)
    @setState {active_by_key}

  _should_deactivate: ->
    @state.active_by_key.includes true

  _deactivate: ->
    @setState active_by_key: @state.active_by_key.withMutations (mutable_keys) ->
      mutable_keys.forEach (__, key) ->
        mutable_keys.set(key, false)

  render: ->
    <div className="arrow-keys">
      {@state.active_by_key.entrySeq().toJS().map (entry, index) ->
         [key, active] = entry
         <Key pressed={active} keytype={key} key={index}></Key>
       }
    </div>


module.exports = ArrowKeys