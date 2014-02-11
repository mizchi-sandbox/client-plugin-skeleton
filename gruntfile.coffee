module.exports = (grunt) ->
  grunt.loadNpmTasks 'grunt-bower-concat'
  grunt.loadNpmTasks 'grunt-mocha-phantomjs'
  grunt.loadNpmTasks 'grunt-browserify'
  grunt.loadNpmTasks 'grunt-este-watch'
  grunt.loadNpmTasks 'grunt-contrib-connect'
  grunt.initConfig
    bower_concat:
      all:
        dest: 'test/assets/vendor.js'
        dependencies:
          'chai-jquery': ['jquery','chai']
        bowerOptions:
          relative: false

    browserify:
      app:
        files:
          'dist/plugin.js': [
            'src/**/*.coffee'
          ]
        options:
          transform: ['coffeeify']

      sample:
        files:
          'sample_proj/sample.js': [
            'sample_proj/**/*.coffee'
          ]
        options:
          transform: ['coffeeify']

      test:
        files:
          'test/assets/test.js': [
            'test/**/*.coffee'
          ]
        options:
          transform: ['coffeeify']

    mocha_phantomjs:
      options:
        reporter: 'spec'
      all: ['test/assets/test.html']

    esteWatch:
      options:
        dirs: ['src/**/', 'test/**/']
      coffee: (filepath) ->
        ['build', 'test']

    connect:
      app:
        options:
          port: 8888
          base: '.'

  grunt.registerTask "build", ["bower_concat", "browserify"]
  grunt.registerTask "default", ["build"]
  grunt.registerTask "test", ["build", "mocha_phantomjs"]
  grunt.registerTask "server", ["connect", "esteWatch"]
