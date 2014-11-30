TypesController = ($http) -> 
	@types = []

	$http.get '/api/type/'
		.then (response) =>
			@types = response.data

angular.module 'best.controllers'
	.controller 'TypesController', ['$http', TypesController]