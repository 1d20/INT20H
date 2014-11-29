MainController = ($http, SessionService) -> 

	SessionService.login()
	
	@user = ''

	getUserSuccess = (response) =>
		@user = response.data.username

	getUserError = (reject) ->
		console.log reject

	$http.get 'json/index.json' 
		.then getUserSuccess, getUserError

angular.module 'best.controllers'
	.controller 'MainController', ['$http', 'SessionService', MainController]