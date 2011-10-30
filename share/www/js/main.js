$(function(){

/*
 * Panels
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

/*
 * MetaSpace
 */
$('a#metaspace-trigger').fancybox({
  width         : '90%',
  height        : '90%',
  autoScale     : true,
  transitionIn  : 'elastic',
  transitionOut : 'elastic',
  easingIn      : 'easeOutBack',
  easingOut     : 'easeInBack',
  type          : 'iframe'
});

/*
 * Space Dialog 
 */
$.mn.spaceDialog = $('#space-dialog').dialog({
  autoOpen  : false,
  width     : 420,
  height    : 330,
  resizable : false
});
$('#space-dialog button').button();

// TOOD
// - form validation
$('#space-dialog form').submit(function(ev){
  var title, path, wd, hi;
  var space = $.mn.spaceDialog;
  var form  = $(this);
  title  = form.find('input[name=title]').val();
  path   = form.find('input[name=path]').val();
  width  = form.find('input[name=width]').val();
  height = form.find('input[name=height]').val();
  $.ajax({
    type : 'PUT',
    url  : '/api/v5/object/space/' + encodeURIComponent(path),
    data : {
      title  : title,
      width  : width,
      height : height
    }
  })
  .success(function(r){
    console.log('success', r);
    space.dialog('close');
    form.find('input[name=title]').val('');
    form.find('input[name=path]').val('');
    form.find('input[name=width]').val('');
    form.find('input[name=height]').val('');
    $('a#metaspace-trigger').click();
  })
  .error(function(r){
    console.log('error', r);
  });
  return false;
});

/*
 * Note
 */
$('#new-note-trigger').click(function(ev){
  var top = ($( window) . height() - $( this) . outerHeight()) / 2;
  var left = ($( window) . width() - $( this) . outerWidth()) / 2;
  var note = new $.mn.Note({ x: left, y: top });
  return false;
});

$.mn.spaceDialog.dialog('option', 'virgin', true);
$('#space-dialog-trigger').click(function(ev){
  var target = $(this);
  var space  = $.mn.spaceDialog;
  if (space.dialog('isOpen')) { return false; }
  space.dialog('open');
  /* http://stackoverflow.com/questions/744554/jquery-ui-dialog-positioning */
  if (space.dialog('option', 'virgin')) {
    space.dialog('widget').position({
      my: 'left bottom',
      at: 'right top',
      of: target
    });
    space.dialog('option', 'virgin', false);
  }
  return false;
});

/*
 * Grid
 */
$('a.toggle-grid').click(function(ev){
  $('body').toggleClass('grid');
  // $.mn.toggleGrid();
  // - should toggle the grid class on body
  // - should find all modifiable widgets on page and
  //   - .draggable('option', 'grid', [8,8]
  //   - .resizable('option', 'grid', [8,8]
  //   - on first click only, snap to grid
  return false;
});











/*
 * Demo
 */
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
