TypeController = ($scope, $routeParams, $http) -> 
	self = @
	@type = {}
	@fields = {}
	@node = {}
	@parent = {}
	@parents = []

	@addNew = =>
		data = angular.copy @node
		$http.post "/api/type/#{$routeParams.typeId}/create", data
			.then (response) =>
				@node = {}

	@mapClicked = (data) ->
		$scope.$apply ->
			self.node.latlng = lat: data.lat, lng: data.lng

	$http.get "/api/type/#{$routeParams.typeId}"
		.then (response) =>
			@type = response.data
			console.log @type
			@fields = @type.attrs.split ','

			$http.get "/api/type/#{@type.parent_types[0]}"
				.then (res) => 
					@parent.name = res.data.name

					$http.get "/api/label/#{@parent.name}"
						.then (parents) =>
							@parents = parents.data
			

angular.module 'best.controllers'
	.controller 'TypeController', ['$scope', '$routeParams', '$http', TypeController]