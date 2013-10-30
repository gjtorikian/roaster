module.exports = (grunt) ->
  grunt.initConfig
    pkg: grunt.file.readJSON('package.json')

    coffee:
      glob_to_multiple:
        expand: true
        cwd: 'src'
        src: ['*.coffee']
        dest: 'lib'
        ext: '.js'

    coffeelint:
      options:
        no_empty_param_list:
          level: 'error'
        max_line_length:
          level: 'ignore'

      src: ['src/**/*.coffee']
      test: ['test/**/*.coffee']

    shell:
      test:
        command: 'node node_modules/jasmine-focused/bin/jasmine-focused --captureExceptions --coffee test/'
        options:
          stdout: true
          stderr: true
          failOnError: true

  grunt.loadNpmTasks('grunt-contrib-coffee')
  grunt.loadNpmTasks('grunt-shell')
  grunt.loadNpmTasks('grunt-coffeelint')
  grunt.registerTask('lint', ['coffeelint'])
  grunt.registerTask('default', ['test'])
  grunt.registerTask('test', ['coffee', 'lint', 'shell:test'])
