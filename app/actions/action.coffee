_ = require 'underscore'
{errors} = require '../utility'
Immutable = require 'immutable'
{covenance, ABC} = require 'covenance'


AbstractAction = ABC
  name: 'AbstractAction'
  klass:
    covenance: covenance.of(attribute: 'validate_payload', validator: _.isFunction)
    props:
      value_of: (payload) ->
        @validate_payload(payload)
        @post_value_of_hook(payload)
      post_value_of_hook: (payload) ->
        instance = new @
        instance.payload = payload
        instance
  proto:
    props:
      toString: ->
        @constructor.name
      is_a: (klass) ->
        @ instanceof klass

module.exports = AbstractAction