src = __dirname
dest = __dirname + '/../static'
bower = src + '/bower_components'

module.exports = 
	templates:
		src: [src + '/jade/**/*.jade']
		dest: dest
	compass:
		src: [src + '/sass/**/*.sass']
		dest: dest + '/css/'
	vendors:
		js:
			src: [
				bower + '/jquery/dist/jquery.js'
				bower + '/angular/angular.js'
			]
			dest: dest + '/js'
	coffee:
		src: [
			src + '/coffee/filters.coffee'
			src + '/coffee/services.coffee'
			src + '/coffee/directives.coffee'
			src + '/coffee/controllers.coffee'
			src + '/coffee/filters/*.coffee'
			src + '/coffee/services/*.coffee'
			src + '/coffee/directives/*.coffee'
			src + '/coffee/controllers/*.coffee'
			src + '/coffee/app.coffee'
		]
		dest: dest + '/js'
	json:
		src: [src + '/json/**/*.json']
		dest: dest + '/json'
