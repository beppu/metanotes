$(function(){

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

});
