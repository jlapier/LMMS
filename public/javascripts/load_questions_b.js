/* 
 * load up the questions for the mock-up
 *
 * yes, you can cheat and look at this file - but then you wouldn't learn anything, would you? 
 * if this were a real test, all this stuff would be on the server anyway
 *
 */

var q1 = new QuizQuestion("On what date did the one-year timeline for timely correction begin?",
              [ new QuizAnswer("August 20, 2007"),
                new QuizAnswer("August 1, 2007"),
                new QuizAnswer("January 1, 2007") ],
              "August 20, 2007 was the date on which the State notified the EIS program of the noncompliance."
          );

var q2 = new QuizQuestion("By what date must the State verify correction of the finding in order to report that the finding was timely corrected?",
              [ new QuizAnswer("August 20, 2008"),
                new QuizAnswer("January 1, 2008"),
                new QuizAnswer("January 1, 2009"),
                new QuizAnswer("August 20, 2009") ],
              "August 20, 2008 is one year after the date on which the State notified the LEA of the noncompliance."
          );

var q3 = new QuizQuestion("In which FFY did the State make the finding of noncompliance?",
              [ new QuizAnswer("FFY 2007"),
                new QuizAnswer("FFY 2006"),
                new QuizAnswer("FFY 2005"),
                new QuizAnswer("FFY 2008") ],
              "The state notified the LEA of the noncompliance on August 20, 2007, which is during the FFY 2007 (July 1, 2007-June 30,2008)."
          );

var q4 = new QuizQuestion("In which APR must the State report on the correction of the noncompliance?",
              [ new QuizAnswer("The FFY 2008"),
                new QuizAnswer("The FFY 2007"),
                new QuizAnswer("The FFY 2009"),
                new QuizAnswer("never"),
                new QuizAnswer("The FFY 2010") ],
              "The State must report on the correction in the APR for FFY 2008 (due February 2, 2010)."
          );

var quiz_questions = [q1, q2, q3, q4];