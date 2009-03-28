var NestedAttributesJs = {
  add : function(e) {
    element = Event.findElement(e);
    template = eval(element.href.replace(/.*#/, '') + '_template');
    element.insert( { before: NestedAttributesJs.replace_ids(template) } );
  },
  replace_ids : function(template){
    var new_id = new Date().getTime();
    return template.replace(/NEW_RECORD/g, new_id);
  }
}

Event.observe(window, 'load', function(){
  $$('.add').each(function(link){
    link.observe('click', NestedAttributesJs.add);
  });
});

