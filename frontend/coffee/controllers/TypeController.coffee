TypeController = ($routeParams, $http) -> 
	@type = {}

	$http.get "/api/type/#{$routeParams.typeId}"
		.then (response) =>
			console.log response
			@type = response.data

angular.module 'best.controllers'
	.controller 'TypeController', ['$routeParams', '$http', TypeController]