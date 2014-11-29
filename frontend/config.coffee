src = __dirname
dest = __dirname + '/../static'
bower = src + '/bower_components'

module.exports = 
	templates:
		src: [src + '/jade/**/*.jade']
		dest: dest
	compass:
		src: [src + '/sass/**/*.sass']
		dest: dest + '/css'
	vendors:
		css:
			src: [
				bower + '/bootstrap/dist/css/bootstrap.min.css'
				bower + '/bootswatch-dist/css/bootstrap.min.css'
				bower + '/leaflet/dist/leaflet.css'
			]
			dest: dest + '/css'
		js:
			src: [
				bower + '/jquery/dist/jquery.js'
				bower + '/angular/angular.js'
				bower + '/d3/d3.min.js'
				bower + '/leaflet/dist/leaflet.js'
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
