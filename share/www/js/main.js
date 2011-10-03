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
/*
$.mn.panels.add('reddit', new $.mn.IframePanel({
  id    : 'reddit_panel',
  icon  : 'http://www.reddit.com/static/favicon.ico',
  title : 'Reddit Panel',
  url   : 'http://m.reddit.com/',
  css   : { width: '420px' },
  width : '420px'
}));
*/
$.mn.panels.add('help', new $.mn.IframePanel({
  id    : 'help_panel',
  icon  : '/images/question.ico',
  title : 'Help Panel',
  url   : '/@help',
  css   : { width: '420px' },
  width : '420px'
}));

$('a#metaspace').fancybox({
  width         : '90%',
  height        : '90%',
  autoScale     : true,
  transitionIn  : 'elastic',
  transitionOut : 'elastic',
  easingIn      : 'easeOutBack',
  easingOut     : 'easeInBack',
  type          : 'iframe'
});

$('a.toggle-grid').click(function(ev){
  $('body').toggleClass('grid');
  // $.mn.toggleGrid();
  // - should toggle the grid class on body
  // - should find all modifiable widgets on page and
  //   - .draggable('option', 'grid', [8,8]
  //   - .resizable('option', 'grid', [8,8]
  //   - on first click only, snap to grid
});

// demo
document.onselectstart = function () { return false; };             
jsPlumb.DefaultDragOptions = { cursor: "pointer", zIndex:2000 };
jsPlumb.setMouseEventsEnabled(true);

var n1 = new $.mn.Note({ x: 98,   y: 472 });
var n2 = new $.mn.Note({ x: 1019, y: 23  });
var n3 = new $.mn.Note({ x: 369,  y: 533 });

var anchors = [[0.2, 0, 0, -1], [1, 0.2, 1, 0], [0.8, 1, 0, 1], [0, 0.8, -1, 0] ],
exampleColor = '#9a9',
exampleDropOptions = {
  tolerance:'touch',
  hoverClass:'dropHover',
  activeClass:'dragActive'
}, 
connectorStyle = {
  gradient:{stops:[[0, exampleColor], [0.5, '#323'], [1, exampleColor]]},
  lineWidth:1,
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
