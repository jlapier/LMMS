var ShowHideLink = Behavior.create({
  initialize: function(show_effect, hide_effect, show_effect_params, hide_effect_params, hide_me) {
    this.showEffect = show_effect;
    this.hideEffect = hide_effect;
    this.showEffectParams = show_effect_params;
    this.hideEffectParams = hide_effect_params;
    this.showClassName = this.element.href.toQueryParams()['show'];
    this.hideClassName = this.element.href.toQueryParams()['hide'];
    this.hideMe = hide_me;
  },
  onclick: function(e) {
    e.stop();
    if(this.showClassName) $$('.'+this.showClassName).invoke(this.showEffect || 'show', this.showEffectParams);
    if(this.hideClassName) $$('.'+this.hideClassName).invoke(this.hideEffect || 'hide', this.hideEffectParams);
    if(this.hideMe) { e.element().hide(); }
  }
})

var QuestionForm = Behavior.create({
  initialize: function() {
    this.index = this.element.readAttribute('index');
    this.quiz_question = quiz_questions[this.index];
  },

  onsubmit: function() {
    var the_input = Form.getInputs(this.element,'radio','answer').find(function(radio) { return radio.checked; });
    if ( !Object.isUndefined(the_input) ) {
      var that = this;
      new Ajax.Request(document.location.href + '/quiz_questions/' + that.quiz_question.question_id + '/get_answer?my_answer=' + 
            escape(that.quiz_question.answers[the_input.value]), {
        onSuccess: function(request) {
          resp = request.responseText.evalJSON();
          that.quiz_question.correct_answer = resp.correct_answer;
          that.quiz_question.explanation_text = resp.explanation;
          that.quiz_question.answer_as(the_input.value);
          that.quiz_question.update_question();
          if ( quizFinished() ) {
            $('next_arrows').hide();
            $('review_score').show();
          } else {
            setTimeout(function() {
              if(that.index == 0) {
                $$('.prev_link').invoke('hide');
              } else {
                $$('.prev_link').invoke('show');
              }
              $('next_arrows').appear();
            }, 1750 );
          }
        }
      });

      
    }
    return false;
  }
});



var GotoQuestion = Behavior.create({
  initialize: function() {

  },

  onclick: function() {
    if( this.element.hasClassName('next_link') ) {
      on_question_index += 1;
    } else {
      on_question_index -= 1;
    }
    if( on_question_index < 0 ) { on_question_index = quiz_questions.size() - 1; }
    if( on_question_index >= quiz_questions.size() ) { on_question_index = 0; }
    $('correct_popup').fade();
    $('incorrect_popup').fade();
    $('explanation').fade();
    if(quiz_questions[on_question_index].answered_index === null) {
      $('next_arrows').fade();
    } else{
      $('next_arrows').appear();
    }
    
    Effect.SlideUp('question_display');
    setTimeout(function() {
      $('question_display').update( quiz_questions[on_question_index].to_html(on_question_index) );
      q_form_css_id = '#question'+ on_question_index + '_form';
      Event.addBehavior({ '.question_form': QuestionForm() } );
      Effect.SlideDown('question_display');
      

    }, 1750);
    return false;
  }
});