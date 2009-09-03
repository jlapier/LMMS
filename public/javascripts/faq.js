var MyUtils = {
  divitize: function (element, html_class){
    parent = element.up();
    html = element.innerHTML;
    d = DOM.Builder.fromHTML('<div class="'+html_class+'" id="'+element.identify()+'">'+html+'<div>');
    element.remove();
    parent.insert( d );
    return d;
  }
}

Element.addMethods(MyUtils);

Event.observe(window, 'load', function() {
  Event.addBehavior({
    'body': function() {
      $$('.answers').invoke('divitize', 'answer_div').invoke('hide');
      $('answers_header').hide();
    },
    '.questions a:click': function(e) {
      el = e.element();
      answer = $(el.readAttribute('href').sub('#', '', 1)).up('.answer_div');
      if(answer.visible()) {
        Effect.SlideUp(answer);
      } else {
        el.up('li').insert( { bottom: answer });
        answer.addClassName('inserted_answer');
        Effect.SlideDown(answer);
      }
      e.stop();
    }
  })
})
