var QuizQuestion = Class.create({
  // list answers as an array of strings, preferably in a random order
  initialize: function(question, question_id, answers) {
    this.question = question;
    this.question_id = question_id;
    this.correct_answer = null;
    this.answered_index = null;
    this.answers = answers;
    this.explanation_text = null;
  },

  to_html: function(index) {
    this.index = index;
    var out = '<div id="question'+ index + '">';
    out += '<strong style="font-size: 150%;">' + (this.index+1) + '. </strong>' + this.question;

    // if hasn't been answered then display the form
    if( this.answered_index === null) {
      out += '<form class="question_form" id="question'+ index + '_form" index="' + index + '"><ul>';
      a_index = 0;
      this.answers.each(function(answer) {
        out += '<li class="answer" id="answer_' + a_index + '">';
        out += '<input type="radio" name="answer" id="question'+ index + '_answer" value="' + a_index + '"/> ' ;
        out += answer + '</li>';
        a_index += 1;
      });
      out += '</ul>';
      out += '<input type="submit" value="Submit Answer" id="submit_button"/>';
      out += '</form>';

    // if already answered, show the correct answer and incorrect answer if it was chosen
    } else {
      out += '<ul>'
      out += '<li class="answer">Correct answer: <span class=" correct_answer">';
      out += this.correct_answer + '</span></li>';
      if (!this.is_correct()) {
        out += '<li class="answer">Your answer: <span class="incorrect_answer">';
        out += this.answers[this.answered_index] + '</span></li>';
      }

      out += '</ul>';
      out += '<div class="explanation">' + this.explanation_text + '</div>';
    }
    out += '</div>';
    return out;
  },

  answer_as: function(a_index) {
    this.answered_index = a_index;
  },

  is_correct: function() {
    if( this.answered_index === null ) {
      return false;
    } else {
      return this.correct_answer === this.answers[this.answered_index];
    }
  },

  update_question: function() {
    $('question'+ this.index + '_form').disable();
    $('submit_button').fade();
    var the_question = this;
    $$('li.answer').each(function(answer_li) {
      ans_value = answer_li.down('input').value;
      if( the_question.correct_answer === the_question.answers[ans_value]) {
        answer_li.addClassName('correct_answer');
      } else if( the_question.answered_index === ans_value ) {
        answer_li.addClassName('incorrect_answer');
      } else {
        answer_li.fade();
      }
    })
    $('explanation').update(this.explanation_text);
    setTimeout(function() {
      if( the_question.is_correct() ) {
        $('correct_popup').appear();
      } else {
        $('incorrect_popup').appear();
      }
      setTimeout(function() {
        $('explanation').appear();
      }, 500 );
    }, 1750);
  }
});