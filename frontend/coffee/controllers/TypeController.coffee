TypeController = ($scope, $routeParams, $http, $location) -> 
	self = @
	@type = {}
	@fields = {}
	@node = {}
	@parent = {}
	@parents = []

	@likeIt = (node) ->
		node.likes = if node.is_liked then node.likes - 1 else node.likes + 1
		node.is_liked = !node.is_liked
		$http.post "/api/node/#{node.id}/like/"
			.then (response) ->
				node.likes = response.data.likes

	@addNew = =>
		parent = @node.parent
		node = angular.copy @node
		delete node.parent
		data =
			values: JSON.stringify(node)
			type: $routeParams.typeId
			parent: parent

		$http.post "/api/node/add", data
			.then (response) =>
				@node = {}
				$location.path "/types/#{@type.id}"

	@mapClicked = (data) ->
		$scope.$apply ->
			self.node.lat = data.lat
			self.node.lng = data.lng

	$http.get "/api/type/#{$routeParams.typeId}"
		.then (response) =>
			@type = response.data
			@fields = @type.attrs.split ','

			$http.get "/api/label/#{@type.name}"
				.then (res) => 
					@type.nodes = res.data
					$scope.$broadcast('nodes.loadend', res.data)

			$http.get "/api/type/#{@type.parent_types[0]}"
				.then (res) => 
					@parent = res.data

					$http.get "/api/label/#{@parent.name}"
						.then (parents) =>
							@parents = parents.data
			

angular.module 'best.controllers'
	.controller 'TypeController', ['$scope', '$routeParams', '$http', '$location', TypeController]