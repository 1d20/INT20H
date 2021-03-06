src = __dirname
dest = __dirname + '/../static'
bower = src + '/bower_components'

module.exports = 
	index:
		src: src + '/jade/index.jade'
		dest: __dirname + '/../templates'
	templates:
		src: [src + '/jade/templates/**/*.jade']
		dest: dest + '/templates'
	compass:
		src: [src + '/sass/**/*.sass']
		dest: dest + '/css'
	images:
		src: [src + '/images/*.png']
		dest: dest + '/images'
	vendors:
		css:
			src: [
				bower + '/bootstrap/dist/css/bootstrap.min.css'
				bower + '/bootswatch-dist/css/bootstrap.min.css'
				bower + '/font-awesome/css/font-awesome.min.css'
				bower + '/leaflet/dist/leaflet.css'
				bower + '/c3js-chart/c3.css'
			]
			dest: dest + '/css'
		fonts:
			src: [
				bower + '/font-awesome/fonts/*'
			]
			dest: dest + '/fonts'
		js:
			src: [
				bower + '/jquery/dist/jquery.js'
				bower + '/angular/angular.js'
				bower + '/angular-route/angular-route.js'
				bower + '/d3/d3.js'
				bower + '/c3js-chart/c3.js'
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
