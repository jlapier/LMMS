Array.prototype.shuffle = function() {
  function randOrd(){return (Math.round(Math.random())-0.5); }
  this.sort( randOrd );
} 



var quiz_questions = [];

function quizFinished() {
  return quiz_questions.all(function(q) { return q.answered_index != null });
}

function loadStats() {
  $('review_score').hide();
  qs = quiz_questions.partition(function(q) { return q.is_correct() });
  qs_got_right = qs[0];
  qs_got_wrong = qs[1];
  score = (qs_got_right.size() / quiz_questions.size() * 100).round();
  out = '<h2>Example Complete!</h2>';
  out += '<p>You got ' + qs_got_right.size() + ' question(s) right and ';
  out += qs_got_wrong.size() + ' question(s) wrong.</p>';
  out += '<p>Your score: <strong>' + score + '%</strong></p>';
  if ( on_example == "A" ) {
    out += '<p class="arrow_link" style="margin-top: 50px; padding: 10px; text-align:right;">'
    out += '<a href="example_B.html" >Move on to example B<img src="../images/NextArrow.png" style="vertical-align:middle; padding-left: 10px;"/></a></p>'
  } else if ( on_example == "B" ) {
    out += '<p class="arrow_link" style="margin-top: 50px; padding: 10px; text-align:right;">'
    out += '<a href="example_C.html" >Move on to example C<img src="../images/NextArrow.png" style="vertical-align:middle; padding-left: 10px;"/></a></p>'
  }  
  $('content').update(out);
}
