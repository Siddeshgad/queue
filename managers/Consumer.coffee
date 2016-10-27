async = require('async');
config = require('config')

class Consumer

  constructor: (@sequelize, @wagner) ->
    @Message = @wagner.get('message')
    @Queue = @wagner.get('Queue')

  getMessages: (callback) =>
    async.map @Queue.list, @processMessage, (err, result) =>
      if !err
        return callback(null, "Processed message")
      else
        return callback(err)

  processMessage: (message, callback) =>
    async.waterfall [
      async.apply(@lockMessage, message),
      @transformMessage
      @updateMessage
      @removeMessage
    ], (err, result) =>
      if !err
        return callback(null, result)
      else
        if message.get('lock')
          message.setDataValue('lock',false)

        return callback(null, err)

  lockMessage: (message, callback) =>
    if !message.get('lock')
      message.setDataValue('lock',true)
      return callback(null, message)
    else
      return callback("Message is already locked.")

  ###transformMessage: (message,callback) =>
    console.log(message.get('body'))
    return callback(null, message)###

  Consumer::transformMessage = async.timeout ((message,callback) =>
      ###replace this with some processing script###
      console.log(message.get('body'))
      return callback(null, message)
    ), config.get('timeout')

  updateMessage: (message,callback) =>
    @Message.update({
      processed: true
    },
      where:
        id: message.get('id')
    ).then (updateStatus) =>
      console.log('Message updated.')
      message.setDataValue('processed',true)
      return callback(null, message)
    .catch (err) =>
      console.log("Got error while updating message record.")
      console.log(err)
      return callback(err.message + " Got error while updating message record.")

  removeMessage: (message, callback) =>
    @Queue.list.forEach (msgObj,index) =>
      if msgObj.get('id') == message.get('id')
        delete @Queue.list[index]

    return callback(null,"Removed message")

module.exports = Consumer