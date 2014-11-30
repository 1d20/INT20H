TypesController = ($http) -> 
	@type = 
		name: ''
		desc: ''
		attrs: ''
		dst: 0

	@types = []

	$http.get '/api/type/'
		.then (response) =>
			@types = response.data
			@type.dst = @types[0].id
			console.log @type

	@addType = =>
		console.log @type
		data = angular.copy @type
		$http.post '/api/type/add', data
			.then (response) =>
				@type = {}

angular.module 'best.controllers'
	.controller 'TypesController', ['$http', TypesController]