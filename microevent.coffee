#
# Based on the work of Jerome Etienne. All credits where due
#

define ->
	class MicroEvent
		on: (e, handler) ->
			@_events or= {}
			@_events[e] or= []
			@_events[e].push handler
			@
		
		
		once: (e, handler) ->
			@on e, =>
				handler.apply @, arguments
				@off e, handler
			@
		
		
		off: (e, handler) ->
			return unless @_events
			@_events[e].splice (@_events[e].indexOf handler), 1 if @_events[e]
			@
		
		
		emit: (e, data) ->
			return unless @_events
			handler.apply @, arguments for handler in @_events[e]
			@
