src = __dirname
dest = __dirname + '/../static'
bower = src + '/bower_components'

module.exports = 
	vendors:
		js:
			src: [
				bower + '/jquery/dist/jquery.js'
				bower + '/angular/angular.js'
			]
			dest: dest + '/js'
	coffee:
		src: [src + '/coffee/app.coffee']
		dest: dest + '/js'
