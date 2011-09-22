(function($){

// collection of panels {{{1
$.mn.panels = {
  ul       : null, // XXX - don't forget to set this when the dom is ready
  list     : [],
  seen     : {},
  selected : null,

  add: function(name, object){
    if (this.seen[name] == null) {
      // list
      this.list.push([name, object]);
      this.seen[name] = this.list.length - 1;
      // dom
      var icon = $('div#factory li.panel_icon').clone();
      icon.find('img').attr({ src: object.icon, title: object.title });
      this.ul.append(icon);
      icon.click(function(ev){ 
        $('li', this.ul).removeClass('selected');
        $(this).addClass('selected');
        $.mn.panels.select(name);
      });
    } else {
      throw(name + " has already been added.");
    }
  },

  remove: function(name){
    var i = this.seen[name];
    var key;
    if (i != null) {
      // list
      this.list.splice(i, 1);
      delete this.seen[name];
      // dom
      var icon = $('li', this.ul)[i];
      $(icon).remove();
      // reindex
      for (key in this.seen) {
        if (this.seen[key] > i) { this.seen[key]--; }
      }
    } else {
      throw(name + " has not been added.");
    }
  },

  find: function(name) {
    return this.list[this.seen[name]][1];
  },

  select: function(name){
    var selectedPanel = this.find(name);
    if (!selectedPanel) {
      throw(name + " has not been added.");
    }
    if (selectedPanel.exec) {
      selectedPanel.exec();
      return null;
    }
    if (this.selected == name) {
      // hide name
      selectedPanel.hide();
      this.selected = null;
    } else if (this.selected == null) {
      // show name
      selectedPanel.show();
      this.selected = name;
    } else if (this.selected != name) {
      // hide this.selected
      // show name
      var unselectedPanel = this.find(this.selected);
      unselectedPanel.hide();
      selectedPanel.show();
      this.selected = name;
    }
    return this.selected;
  },

  resize: function() {
    var selectedPanel;
    if (this.selected) {
      selectedPanel = this.find(this.selected)
      selectedPanel.resize();
    }
  }
};
$(window).resize(function(ev){ $.mn.panels.resize() });

// prototype for iframe-based panel {{{1
$.mn.IframePanel = function(options) { 
  $.extend(this, options);
  this.sel = '#' + options.id;
  if ($(this.sel).length == 0) {
    var panel = $('<div class="panel"><iframe frameborder="0"></iframe></div>');
    panel.attr({ id: this.id });
    this.css.display = 'none';
    panel.css(this.css);
    $('#panels').append(panel);
  }
  return this;
};
$.mn.IframePanel.prototype = {
  id     : null,
  sel    : null,
  icon   : null,
  title  : null,
  url    : null,
  css    : null,
  virgin : true,

  hide: function() {
    $(this.sel).hide(300, 'easeInBack');
  },

  show: function() {
    var hi = $(window).height();
    if (this.virgin) {
      $(this.sel).find('iframe').attr({ width: this.width, src: this.url });
      this.virgin = false;
    }
    $(this.sel).find('iframe').attr({ height: (hi - 27) + 'px' });
    $(this.sel).css({ height: (hi - 27) + 'px' }).show(300, 'easeOutBack');
  },

  resize: function() {
    if ($(this.sel).css('display') != 'none') {
      $(this.sel).find('iframe').attr('height', ($(window).height() - 27) + 'px');
      $(this.sel).css({ height: ($(window).height() - 27) + 'px' });
    }
  }
};

// panel for searching - TODO

// action for increasing font size {{{1
$.mn.fontIncreaseAction = {
  icon  : '/static/images/font_add.png',
  title : 'increase font size',
  exec  : function() {
    var x = ++$.mn.session.fontSize;
    $('#workspace div.note div.body').css({ fontSize: x + 'pt' });
  }
};

// action for decreasing font size {{{1
$.mn.fontDecreaseAction = {
  icon  : '/static/images/font_delete.png',
  title : 'decrease font size',
  exec  : function() {
    var x;
    if ($.mn.session.fontSize > 0) 
      x = --$.mn.session.fontSize;
    $('#workspace div.note div.body').css({ fontSize: x + 'pt' });
  }
};

// four corners navigation {{{1
$.mn.quickNavPanel = {
  icon  : '/static/images/arrow_out.png',
  title : 'quicknav panel',
  show  : function() {
    $('#quicknav').show();
    $('#watermark, #ad').hide('slow');
  },
  hide  : function() {
    $('#quicknav').hide();
    $('#watermark, #ad').show('slow');
  },
  resize: function() { }
};
// 1}}}

})(jQuery);

// vim:fdm=marker
