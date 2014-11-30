HomeController = ($scope, $http) -> 

	@nodes = []
	$http.get '/api/node/top/20/'
		.then (response) => 
			@nodes = response.data
			$scope.$broadcast('nodes.loadend.forMap', response.data)


angular.module 'best.controllers'
	.controller 'HomeController', ['$scope', '$http', HomeController]
