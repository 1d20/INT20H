TypeController = ($scope, $routeParams, $http) -> 
	self = @
	@type = {}
	@fields = {}
	@node = {}
	@parent = {}
	@parents = []

	@addNew = =>
		parent = @node.parent
		node = angular.copy @node
		delete node.parent
		data =
			values: JSON.stringify(node)
			type: $routeParams.typeId
			parent: parent

		console.log data
		$http.post "/api/node/add", data
			# type (id), values => name,code, parent (node_id)
		# $http.post "/api/node/#{$routeParams.typeId}/create", data
			.then (response) =>
				@node = {}

	@mapClicked = (data) ->
		$scope.$apply ->
			self.node.lat = data.lat
			self.node.lng = data.lng

	$http.get "/api/type/#{$routeParams.typeId}"
		.then (response) =>
			@type = response.data
			console.log @type
			@fields = @type.attrs.split ','

			$http.get "/api/type/#{@type.parent_types[0]}"
				.then (res) => 
					@parent = res.data

					$http.get "/api/label/#{@parent.name}"
						.then (parents) =>
							@parents = parents.data
			

angular.module 'best.controllers'
	.controller 'TypeController', ['$scope', '$routeParams', '$http', TypeController]