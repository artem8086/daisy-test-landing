gulp = require 'gulp'
connect = require 'gulp-connect'
stylus = require 'gulp-stylus'
coffee = require 'gulp-coffee'
uglify = require 'gulp-uglify'
concat = require 'gulp-concat'

gulp.task 'connect', ->
	connect.server
		port: 8080
		livereload: on
		root: '.'

gulp.task 'stylus', ->
	gulp.src 'stylus/*.styl'
		.pipe stylus compress: on
		.pipe gulp.dest 'css'

gulp.task 'concat', ['concat_all', 'concat_head']

gulp.task 'concat_head', ->
	gulp.src [
		'css/main.css',
		'css/media.css',
		'css/header.css']
		.pipe concat 'header.min.css'
		.pipe gulp.dest 'dist'
		.pipe do connect.reload

gulp.task 'concat_all', ->
	gulp.src [
		'css/*.css',
		'!css/main.css',
		'!css/media.css',
		'!css/header.css',
		'!css/fonts.css']
		.pipe concat 'style.min.css'
		.pipe gulp.dest 'dist'
		.pipe do connect.reload

gulp.task 'coffee', ->
	gulp.src 'coffee/*.coffee'
		.pipe do coffee
		.pipe do uglify
		.pipe gulp.dest 'js'
		.pipe do connect.reload

gulp.task 'html', ->
	gulp.src '*.html'
		.pipe do connect.reload

gulp.task 'watch', ->
	gulp.watch 'stylus/*.styl', ['stylus']
	gulp.watch 'css/*.css', ['concat']
	gulp.watch '*.html', ['html']
	gulp.watch 'stylus/*.coffee', ['coffee']

gulp.task 'default', [
	'stylus',
	'concat', 
	'coffee', 
	'connect',
	'watch']
