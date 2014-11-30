excludeHidden = ->
	(key) ->
		key != "lat" && key != "lng" && key != "id" && key != "is_liked" && key != "likes"

angular.module 'best.filters'
	.filter 'excludeHidden', excludeHidden