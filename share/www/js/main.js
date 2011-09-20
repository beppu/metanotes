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

// demo
document.onselectstart = function () { return false; };             
jsPlumb.DefaultDragOptions = { cursor: "pointer", zIndex:2000 };
jsPlumb.setMouseEventsEnabled(true);

var n1 = new $.mn.Note({ x: 8*10, y: 8*8 });
var n2 = new $.mn.Note({ x: 8*60, y: 8*8 });
var n3 = new $.mn.Note({ x: 8*60, y: 8*60 });

var anchors = [[0.2, 0, 0, -1], [1, 0.2, 1, 0], [0.8, 1, 0, 1], [0, 0.8, -1, 0] ],
exampleColor = '#00f',
exampleDropOptions = {
  tolerance:'touch',
  hoverClass:'dropHover',
  activeClass:'dragActive'
}, 
connectorStyle = {
  gradient:{stops:[[0, exampleColor], [0.5, '#09098e'], [1, exampleColor]]},
  lineWidth:5,
  strokeStyle:exampleColor
},
endpoint = ["Rectangle", {width:25, height:21} ],
endpointStyle = { fillStyle:exampleColor },
anEndpoint = {
  endpoint:endpoint,
  paintStyle:endpointStyle,
  isSource:true, 
  isTarget:true, 
  anchor:anchors, maxConnections:-1, 
  connectorStyle:connectorStyle
},
aConnection = { 
  endpoint:endpoint,
  endpointStyle:endpointStyle,
  paintStyle : connectorStyle,
  dynamicAnchors:anchors,
  overlays:[ ["Arrow", { fillStyle:'#09098e', width:15, length:15 } ] ]
};

jsPlumb.connect({ source: n1._id, target: n2._id }, aConnection);
jsPlumb.connect({ source: n2._id, target: n3._id }, aConnection);

$('div.space div.widget').live('drag',   function(){ jsPlumb.repaintEverything() });
$('div.space div.widget').live('resize', function(){ jsPlumb.repaintEverything() });

});
