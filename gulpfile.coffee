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

gulp.task 'compass', ->
	gulp.src config.compass.src
		.pipe compass project: __dirname + '/frontend', css: 'css', sass: 'sass', image: 'images'
	    .on 'error', (error) ->
	      console.log error
	      this.emit 'end'

	    .pipe concat('styles.css')
	    .pipe gulp.dest config.compass.dest

gulp.task 'vendors', ->
	gulp.src config.vendors.js.src
		.pipe concat('vendors.js')
		.pipe gulp.dest config.vendors.js.dest

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
    gulp.watch config.vendors.js.src, ['vendors']
    gulp.watch config.coffee.src, ['coffee']

gulp.task 'dev', [
    'templates'
    'compass'
    'vendors'
    'coffee'
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
]
