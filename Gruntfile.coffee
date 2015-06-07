module.exports = (grunt) ->
  require('load-grunt-tasks')(grunt)

  grunt.initConfig
    pkg: grunt.file.readJSON 'package.json'
    mochaTest:
      test:
        options:
          require: [
            'coffee-script/register'
            'coffee-coverage/register-istanbul'
          ]
        src: ['spec/*.coffee']
    coffee:
      compile:
        files: [
          expand: true
          src: ['nointro.coffee']
          ext: '.js'
        ]

  grunt.registerTask 'build', ['coffee:compile']
  grunt.registerTask 'test', ['mochaTest']
  grunt.registerTask 'prepublish', ['build']
  grunt.registerTask 'default', ['build', 'test']
