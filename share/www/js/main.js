$(function(){

/*
// construct widget objects
$('div.space div.widget').mnWidget();

// define COMET event handlers
$.ev.handlers.noteCreate = function(ev){
  new $.mn.Note(ev.widget);
};
$.ev.handlers.widgetMove = function(ev){
  var widget = $.mn.objects[ev._id];
  if (!widget) return;
  widget._move(ev.x, ev.y);
};

// start COMET event loop
if ($.mn.channels) {
  $.ev.loop('/@events/'+Date.now(), $.mn.channels);
}
*/

$.mn.panels.ul = $('menu#main');
$.mn.panels.add('reddit', new $.mn.IframePanel({
  id    : 'reddit_panel',
  icon  : 'http://www.reddit.com/static/favicon.ico',
  title : 'Reddit Panel',
  url   : 'http://m.reddit.com/',
  css   : { width: '420px' },
  width : '420px'
}));

});
