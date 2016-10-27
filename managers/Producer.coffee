uuid = require('node-uuid')

class Producer

  constructor: (@sequelize, @wagner) ->
    @Message = @wagner.get('message')
    @Queue = @wagner.get('Queue')

  addMessage: (messageData, callback) =>
    messageId = uuid.v1()

    @Message.create(
      message_id: messageId
      body: messageData.body
    ).then (message) =>
      console.log('Message added successfully.')
      if message
        @Queue.list.push(message)
        return callback(null, messageId)
      else
        return callback("Not able to save message.")
    .catch (err) =>
      console.log("Got error while creating new message record.")
      console.log(err)
      return callback(err.message + " Got error while creating new message record.")

module.exports = Producer
