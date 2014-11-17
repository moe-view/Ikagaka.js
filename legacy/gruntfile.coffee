packageJson = require './package.json'

module.exports = (grunt) ->
  grunt.loadNpmTasks("grunt-contrib-coffee")
  grunt.loadNpmTasks('grunt-contrib-copy')
  grunt.loadNpmTasks("grunt-contrib-watch")
  grunt.loadNpmTasks("grunt-contrib-clean")
  src = "./src"
  dest = "./dest"
  grunt.initConfig
    clean:
      build:
        src: "#{dest}/*"
    coffee:
      build:
        expand: true
        src: [
          '#{src}/**/*.coffee'
        ]
        dest: dest
        ext: '.js'
      options:
        bare: true
        sourceMap: true
    copy:
      build:
        filter: 'isFile',
        files: [
          {src: "#{src}/index.html", dest: "#{dest}/index.html"}
        ]
    watch:
      coffee:
        files:["./src/coffee/*.coffee"],
        tasks:["make"]
      less:
        files:["./src/less/*.less"],
        tasks:["make"]
      html:
        files:["./src/*.html"]
        tasks:["make"]
    test:{}

  grunt.registerTask("make", ["clean:build", "coffee:build", "less:build", "copy:build"])
  grunt.registerTask("default", ["make"])
