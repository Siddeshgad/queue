class Queue

  @list = []

  constructor: (@sequelize, @wagner) ->
    @Message = @wagner.get('message')
    @getMessages()

  getMessages: () =>
    @Message.findAll(
      where: {
        processed: false
      }
      ).then (list) =>
        if list
          console.log('Found ' + list.length + " messages.")
          @list = list
          #return callback(null, list.length)
        else
          #return callback("No messages found.")
      .catch (err) =>
        console.log("Got error while getting all messages.")
        console.log(err)
        #return callback(err.message + " Got error while getting all messages.")

module.exports = Queue