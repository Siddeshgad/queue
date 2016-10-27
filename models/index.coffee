fs = require 'fs'
path = require 'path'
_ = require('underscore')

module.exports = (@sequelize, @wagner) ->

  @models = {}
  excludeFiles = [
    "index.coffee",
    "index.js"
  ]

  fs
  .readdirSync __dirname
  .filter (file) =>
    return (file.indexOf(".") != 0) && excludeFiles.indexOf(file) < 0
  .forEach (file) =>
    try
      model = @sequelize.import(path.join(__dirname, file));
      @models[model.name] = model
    catch err
      console.log(err.message)

  Object.keys(@models).forEach (modelName) =>
    if ("associate" of @models[modelName])
      @models[modelName].associate(@models)

  # To ensure DRY-ness, register factories in a loop
  _.each @models, (value, key) =>
    @wagner.factory key,() ->
      return value

  return @models
