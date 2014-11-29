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
  gulp.src './frontend/jade/**/*.jade'
    .pipe jade()
    .pipe gulp.dest './static/'

gulp.task 'compass', ->
	gulp.src './frontend/sass/**/*.sass'
		.pipe compass project: __dirname + '/frontend', css: 'css', sass: 'sass', image: 'images'
	    .on 'error', (error) ->
	      console.log error
	      this.emit 'end'

	    .pipe concat('styles.css')
	    .pipe gulp.dest 'static/css/'

gulp.task 'vendors', ->
	gulp.src config.vendors.js.src
		.pipe concat('vendors.js')
		.pipe gulp.dest config.vendors.js.dest

gulp.task 'coffee', ->
	gulp.src config.coffee.src
		.pipe coffee()
		.pipe concat('scripts.js')
		.pipe gulp.dest config.coffee.dest

gulp.task 'default', ['bower', 'templates' 'compass', 'vendors', 'coffee']
