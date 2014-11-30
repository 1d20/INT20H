excludeHidden = ->
	(key) ->
		key != "lat" && key != "lng" && key != "id"

angular.module 'best.filters'
	.filter 'excludeHidden', excludeHidden