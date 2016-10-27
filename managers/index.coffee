Producer = require('./Producer')
Queue = require('./Queue')
Consumer = require('./Consumer')

module.exports = (sequelize, wagner) ->

  wagner.factory 'Producer', ->
    return new Producer(sequelize, wagner)

  wagner.factory 'Queue', ->
    return new Queue(sequelize, wagner)

  wagner.factory 'Consumer', ->
    return new Consumer(sequelize, wagner)