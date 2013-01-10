#
# Based on the work of Jerome Etienne. All credits where due
#

define ->
	class MicroEvent
		on: (event, fct) ->
			@_events or= {}
			@_events[event] or= []
			@_events[event].push fct
		
		
		once: (event, fct) ->
			@on event, =>
				fct.call arguments
				@off event, fct
		
		off: (event, fct) ->
			return unless @_events
			@_events[event].splice @_events[event].indexOf fct, 1 if @_events[event]
		
		
		emit: (event) ->
			return unless @_events
			if @_events[event]
				for i in [0...@_events[event].length]
					@_events[event][i].apply @, [].concat event, Array.prototype.slice.call arguments, 1
