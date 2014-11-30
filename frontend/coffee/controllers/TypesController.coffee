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

angular.module 'best.controllers'
	.controller 'TypesController', ['$scope', '$http', TypesController]