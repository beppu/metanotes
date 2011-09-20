(function($){

$.mn = {
  _id : 1,
  id  : function() {
    return this._id++;
  },

  _z : 100,
  z  : function(reset) {
    if (reset) {
    } else {
      return this._z++;
    }
  }
};

// All Objects in the Page
//    key   : CouchDB document id
//    value : JS object
$.mn.objects = {};

// widget mixin
$.mn.widget = {

  x : 0,
  y : 0,
  z : 100,

  width  : 1,
  height : 1,

  _create: function(opts) {
  },
  create: function(opts) {
    var self = this;
    $.mn.objects[this._id] = this;
  },

  _raise: function(z) {
    if (z) {
      this.z = z;
    } else {
      var nextZ = $.mn.z();
      if (nextZ > 2000) {
        // TODO - pagewide zIndex reset?
      }
      this.z = nextZ;
    }
    $(this.id).css({ zIndex: nextZ });
    return this;
  },
  raise: function(z) {
  },

  _move: function(x, y) {
    this.x = x;
    this.y = y;
    $(this.id).css({ top: y+24 +'px', left: x });
  },
  move: function(x, y) {
    var self = this;
    return $.post(
      '/@object/'+this.type+'/'+this._id,
      {
        method : 'move',
        x      : x,
        y      : y
      },
      function(response, textStatus){
        if (response.success) {
          self._move(x, y);
        }
      }
    );
  },

  _resize: function(width, height) {
  },
  resize: function(width, height) {
    var self = this;
  },

  _delete: function(){
  },
  'delete': function() {
    var self = this;
    return $.post(
      '/@object/'+this.type+'/'+this._id,
      {
        method : 'delete',
      },
      function(response, textStatus){
        if (response.success) {
          delete $.mn.objects[self._id];
        }
      }
    );
  }

};

// note widget
$.mn.Note = function(opts){
  $.extend(this, opts);
  var note;
  if (this.el) {
    note = $(this.el);
    this._id = note[0].id;
    this.id  = '#' + this._id;
    delete this.el;
  } else {
    note = $('#factory div.widget.note').clone();
    this._id = 'Note-' + $.mn.id();
    this.id  = '#' + this._id;
    note[0].id = this._id;
    note.css({
      width      : this.width+'px',
      height     : this.height+'px',
      background : this.background
    });
    $('div.space').append(note);
    this._raise();
    this._move(this.x, this.y);
  }
  note.draggable().resizable();
  $.mn.objects[this._id] = this;
  return this;
};
$.mn.Note.prototype = $.extend({}, $.mn.widget, {
  type       : 'Note',
  width      : 198,
  height     : 198,
  background : '#fc4',
  opacity    : 1.00 
});

// image widget
$.mn.Image = function(opts){
  $.extend(this, opts);
  var image;
  if (this.el) {
    image = $(this.el);
    this._id = image[0].id;
    delete this.el;
  } else {
    image = $('#factory div.widget.image').clone();
    $('img', image).attr({ src: this.src });
    $('div.space').append(image);
  }
  image.draggable();
  $.mn.objects[this._id || 'Image-4'] = this;
};
$.mn.Image.prototype = $.extend({}, $.mn.widget, {
  type : 'Image'
});

// new jQuery function(s)
$.fn.extend({
  // widget constructor
  mnWidget: function(options){
    var self = $(this);
  }
});

})(jQuery);
