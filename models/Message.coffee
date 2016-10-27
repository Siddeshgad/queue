_ = require('underscore')

modelName = 'message'

###Model for the table message###
module.exports = (sequelize, DataTypes) ->
  Message = sequelize.define(modelName,
    {
      id:
        type: DataTypes.INTEGER
        autoIncrement: true
        primaryKey: true
        allowNull: false

      message_id:
        type: DataTypes.STRING(100)

      body:
        type: DataTypes.STRING(300)

      processed:
        type: DataTypes.BOOLEAN
        defaultValue: 0,
  }, {
      getterMethods: 
        getLockedStatus: ->
          if _.isBoolean(@lock)
            @setDataValue 'lock', false

      setterMethods: 
        setLock: (value) ->
          @setDataValue 'lock', value

      tableName: modelName,
      createdAt: "created_at",
      updatedAt: "updated_at",
      deletedAt: "deleted_at",
      timestamps: true,
      paranoid: true,
      indexes: [
        {
          name: 'idx_message_id',
          fields: ['message_id']
        }
      ]
  }
)