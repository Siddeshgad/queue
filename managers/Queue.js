// Generated by CoffeeScript 1.10.0
var Queue,
  bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

Queue = (function() {
  Queue.list = [];

  function Queue(sequelize, wagner) {
    this.sequelize = sequelize;
    this.wagner = wagner;
    this.getMessages = bind(this.getMessages, this);
    this.Message = this.wagner.get('message');
    this.getMessages();
  }

  Queue.prototype.getMessages = function() {
    return this.Message.findAll({
      where: {
        processed: false
      }
    }).then((function(_this) {
      return function(list) {
        if (list) {
          console.log('Found ' + list.length + " messages.");
          return _this.list = list;
        } else {

        }
      };
    })(this))["catch"]((function(_this) {
      return function(err) {
        console.log("Got error while getting all messages.");
        return console.log(err);
      };
    })(this));
  };

  return Queue;

})();

module.exports = Queue;
