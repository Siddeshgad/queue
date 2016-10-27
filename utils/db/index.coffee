#Initialize Sequelize
Sequelize = require('sequelize')
config = require('config')

if config.has('db')
  dbconfig = config.get('db')
else
  if process.env.NODE_ENV
    dbconfig = require(config.util.getEnv('NODE_CONFIG_DIR') + "/" + process.env.NODE_ENV + '.json')['db']
  else
    dbconfig = require(config.util.getEnv('NODE_CONFIG_DIR') + "/" + 'default.json')['db']


console.log( "Username: ", (process.env.DB_USERNAME || dbconfig.options.replication.write.username))
#Default DB settings, based on NODE_ENV

exports.sequelize = new Sequelize((process.env.DB_NAME || dbconfig.database), (process.env.DB_USERNAME || dbconfig.username), (process.env.DB_PASSWORD || dbconfig.password) , dbconfig.options)