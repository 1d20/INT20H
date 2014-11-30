SessionService = ($http) -> 

	service = 
		access_token: localStorage.getItem 'access_token'
		token_type: localStorage.getItem 'token_type'
		expires_in: localStorage.getItem 'expires_in'
		refresh_token: localStorage.getItem 'refresh_token'
		login: ->

angular.module 'best.services'
	.factory 'SessionService', ['$http', SessionService]