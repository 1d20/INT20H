gulp = require 'gulp'
jade = require 'gulp-jade'
coffee = require 'gulp-coffee'
concat = require 'gulp-concat'
uglify = require 'gulp-uglify'
compass = require 'gulp-compass'

config = require './frontend/config'

install = require "gulp-install"

gulp.task 'bower', ->
	gulp.src ['./frontend/bower.json']
  		.pipe install()

gulp.task 'templates', ->
  gulp.src config.templates.src
    .pipe jade()
    .pipe gulp.dest config.templates.dest

gulp.task 'images', ->
  gulp.src config.images.src
    .pipe gulp.dest config.images.dest

gulp.task 'compass', ->
	gulp.src config.compass.src
		.pipe compass project: __dirname + '/frontend', css: 'css', sass: 'sass', image: 'images'
	    .on 'error', (error) ->
	      console.log error
	      this.emit 'end'

	    .pipe concat('styles.css')
	    .pipe gulp.dest config.compass.dest

gulp.task 'vendors:css', ->
    gulp.src config.vendors.css.src
        .pipe concat 'vendors.css'
        .pipe gulp.dest config.vendors.css.dest

gulp.task 'vendors:fonts', ->
	gulp.src config.vendors.fonts.src
		.pipe gulp.dest config.vendors.fonts.dest

gulp.task 'vendors:js', ->
	gulp.src config.vendors.js.src
		.pipe concat('vendors.js')
		.pipe gulp.dest config.vendors.js.dest

gulp.task 'vendors', ['vendors:css', 'vendors:fonts', 'vendors:js']

gulp.task 'coffee', ->
	gulp.src config.coffee.src
		.pipe coffee()
		.pipe concat('scripts.js')
		.pipe gulp.dest config.coffee.dest

gulp.task 'json', ->
    gulp.src config.json.src
        .pipe gulp.dest config.json.dest

gulp.task 'watch', ->
    gulp.watch config.templates.src, ['templates']
    gulp.watch config.compass.src, ['compass']
    gulp.watch config.vendors.js.src, ['vendors:js']
    gulp.watch config.vendors.css.src, ['vendors:css']
    gulp.watch config.images.src, ['images']
    gulp.watch config.coffee.src, ['coffee']
    gulp.watch config.json.src, ['json']

gulp.task 'dev', [
    'templates'
    'compass'
    'vendors'
    'coffee'
    'images'
    'json'
    'watch'
]

gulp.task 'default', [
    'bower' 
    'templates'
    'compass'
    'vendors'
    'json'
    'coffee'
    'images'
]
