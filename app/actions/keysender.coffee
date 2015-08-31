Dispatcher = require '../dispatcher'
_ = require 'underscore'
Immutable = require 'immutable'

{KeyDownAction} = require './keydown'

INITIALIZED = false
MAC_COMMAND = Immutable.Set [
  91 # ⌘
  93 # ⌘
]

KeySender = Object.create {},
  # jQuery is a dependency for event normalization
  dependencies:
    enumerable: true
    value: Immutable.Map [
      ['jQuery', '$']
    ]

  initialize:
    enumerable: true
    value: (dependencies) ->
      if INITIALIZED
        @
      else
        unless _.isObject dependencies
          throw new Error 'Pass an object with required dependencies'
        @dependencies.entrySeq().forEach (entry) =>
          [external_name, internal_name] = entry
          unless _.has dependencies, external_name
            throw new Error "Couldn't find dependency #{external_name}"
          @[internal_name] = dependencies[external_name]

      INITIALIZED = true
      @$(document).keyup (ev) => @_clear_pressed_keys()
      @

  listen:
    enumerable: true
    value: (keycodes, options) ->
      @_validate_listen keycodes, options
      keycodes = Immutable.Set(keycodes)
      options = _.defaults options, prevent_default: false

      @$(document).keydown (ev) =>
        bubbled = ev
        keycode = ev.which
        @_add_pressed_key(keycode)
        if keycodes.has keycode
          Dispatcher.dispatch KeyDownAction.value_of({keycode})
          if @_should_prevent_default(ev, options)
            bubbled = false
        bubbled

  _should_prevent_default:
    value: (ev, options) ->
      if options.prevent_default
        if @_pressed_keys.intersect(MAC_COMMAND).size > 0
          false
        else if ev.altKey || ev.ctrlKey || ev.shiftKey
          false
        else
          true
      else
        false

  _pressed_keys:
    writable: true
    value: Immutable.Set()

  _add_pressed_key:
    value: (keycode) ->
      @_pressed_keys = @_pressed_keys.add(keycode)

  _clear_pressed_keys:
    value: ->
      @_pressed_keys = @_pressed_keys.clear()

  _validate_listen:
    value: (keycodes, options) ->
      unless INITIALIZED?
        throw new Error("Didn't properly initialize; call .initialize first!")
      unless keycodes instanceof Immutable.Iterable|| Array.isArray(keycodes)
        throw new Error("keycodes Immutable.Iterable/array required")
      if options? && !_.isObject options
        throw new Error("options argument should be an object")


module.exports = KeySender