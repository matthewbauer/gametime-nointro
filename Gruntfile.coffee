module.exports = (grunt) ->
  grunt.initConfig
    pkg : grunt.file.readJSON('package.json')
    mochaTest :
      test :
        options :
          reporter : 'spec',
          require : 'coffee-script/register'
        src : ['test.coffee']
    coffee :
      compile :
        files : [
          expand : true
          src : ['nointro.coffee']
          ext : '.js'
        ]
  grunt.loadNpmTasks 'grunt-mocha-test'
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.registerTask 'build', ['coffee:compile']
  grunt.registerTask 'test', ['mochaTest']
  grunt.registerTask 'prepublish', ['build']
  grunt.registerTask 'default', ['build', 'test']
