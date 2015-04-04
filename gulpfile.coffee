gulp                = require 'gulp'
rename              = require 'gulp-rename'
coffee              = require 'gulp-coffee'
uglify              = require 'gulp-uglify'

gulp.task 'coffee', ->
  gulp
    .src(['src/**/*.coffee'])
    .pipe(coffee bare: false)
    .pipe(gulp.dest 'dist/')

gulp.task 'mincoffee', ->
  gulp
    .src(['src/**/*.coffee'])
    .pipe(coffee bare: false)
    .pipe(uglify())
    .pipe(rename suffix: '.min')
    .pipe(gulp.dest 'dist/')

gulp.task 'default', ['coffee', 'mincoffee']