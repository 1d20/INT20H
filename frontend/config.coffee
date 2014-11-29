src = __dirname
build = __dirname + '/../static/js'

module.exports = 
	coffee:
		src: [src + '/coffee/app.coffee']
		build: build