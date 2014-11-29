gulp = require 'gulp'
coffee = require 'gulp-coffee'
concat = require 'gulp-concat'
uglify = require 'gulp-uglify'
compass = require 'gulp-compass'

gulp.task 'compass', ->
	gulp.src './frontend/sass/**/*.sass'
		.pipe compass project: __dirname + '/frontend', css: 'css', sass: 'sass', image: 'images'
	    .on 'error', (error) ->
	      console.log error
	      this.emit 'end'

	    .pipe concat('styles.css')
	    .pipe gulp.dest 'static/css/'

gulp.task 'default', ->
	console.log 'hello'