module.exports = (app, wagner) ->

  Producer = wagner.get('Producer')
  Consumer = wagner.get('Consumer')

  app.post '/queue/store', (req, res, next) ->
    Producer.addMessage req.body, (err,response) ->
      if !err
        res.status(200).json(response)
      else
        res.status(500).json(err)

  app.get '/queue/process', (req, res, next) ->
  	Consumer.getMessages (err,response) ->
      if !err
        res.status(200).json(response)
      else
        res.status(500).json(err)