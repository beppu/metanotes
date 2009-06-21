function modifiable(object) {
  object.yield = null;
  object.rv    = { };
  object.before  = function(method, f) {
    var original = this[method];
    this[method] = function() {
      f.apply(this, arguments);
      return original.apply(this, arguments);
    };
  };
  object.after   = function(method, f) {
    var original = this[method];
    this[method] = function() {
      this.rv[method] = original.apply(this, arguments);
      return f.apply(this, arguments);
    }
  };
  object.around  = function(method, f) {
    var original = this[method];
    this[method] = function() {
      this.yield = original;
      return f.apply(this, arguments);
    }
  };
  return object;
}
