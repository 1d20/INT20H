TypesController = ($scope, $http) -> 
	@type = 
		name: ''
		desc: ''
		attrs: ''
		dst: 0

	@types = []
	@nodes = []

	$http.get '/api/node/top/20/'
		.then (response) => 
			@nodes = response.data
			$scope.$broadcast('nodes.loadend', response.data)


	$http.get '/api/type/'
		.then (response) =>
			@types = response.data
			@type.dst = @types[0].id

	@addType = =>
		data = angular.copy @type
		$http.post '/api/type/add', data
			.then (response) =>
				@type = {}

	@likeIt = (node) ->
		node.likes = if node.is_liked then node.likes - 1 else node.likes + 1
		node.is_liked = !node.is_liked
		$http.post "/api/node/#{node.id}/like/"
			.then (response) ->
				node.likes = response.data.likes

	@download = =>
		svg = $('#chart svg')[0].outerHTML;
		$http.post '/pdf/', svg: svg
			.then (response) => 
				window.open('/static/file.pdf')

angular.module 'best.controllers'
	.controller 'TypesController', ['$scope', '$http', TypesController]