class QuizQuestionsController < ApplicationController
  before_filter :get_learning_module
  before_filter :get_section
  before_filter :get_quiz_page
  before_filter :login_required, :only => [ :new, :create, :edit, :update, :destroy ]
  
  # GET /quiz_questions
  # GET /quiz_questions.xml
  def index
    @quiz_questions = @quiz_page.quiz_questions.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @quiz_questions }
    end
  end

  # GET /quiz_questions/1
  # GET /quiz_questions/1.xml
  def show
    @quiz_question = @quiz_page.quiz_questions.find(params[:id])

    # TODO might want a json response here
    respond_to do |format|
      format.html { redirect_to(learning_module_section_quiz_page_quiz_questions_path) }
      format.xml  { render :xml => @quiz_question }
    end
  end

  def get_answer
    @quiz_question = @quiz_page.quiz_questions.find(params[:id])
    quiz_answer = @quiz_question.quiz_answers.find_by_body(params[:my_answer])
    if quiz_answer
      session[:answer_hash] ||= {}
      session[:answer_hash][@quiz_page.id] ||= {}
      session[:answer_hash][@quiz_page.id][@quiz_question.id] = quiz_answer.id
    end

    respond_to do |format|
      format.js { render :json => { :explanation => @quiz_question.explanation, :correct_answer => @quiz_question.correct_answer.body } }
      format.xml  { render :xml => @quiz_question }
    end
  end

  # GET /quiz_questions/new
  # GET /quiz_questions/new.xml
  def new
    @quiz_question = QuizQuestion.new :quiz_page => @quiz_page

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @quiz_question }
    end
  end

  # GET /quiz_questions/1/edit
  def edit
    @quiz_question = @quiz_page.quiz_questions.find(params[:id])
  end

  # POST /quiz_questions
  # POST /quiz_questions.xml
  def create
    @quiz_question = @quiz_page.quiz_questions.new(params[:quiz_question])
    
    respond_to do |format|
      if @quiz_question.save
        flash[:notice] = "Question '#{@quiz_question.title}' was successfully created."
        format.html { redirect_to(learning_module_section_quiz_page_quiz_questions_path) }
        format.xml  { render :xml => @quiz_question, :status => :created, :location => @quiz_question }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @quiz_question.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /quiz_questions/1
  # PUT /quiz_questions/1.xml
  def update
    @quiz_question = @quiz_page.quiz_questions.find(params[:id])

    respond_to do |format|
      if @quiz_question.update_attributes(params[:quiz_question])
        flash[:notice] = "Question '#{@quiz_question.title}' was successfully updated."
        format.html { redirect_to learning_module_section_quiz_page_quiz_questions_path }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @quiz_question.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /quiz_questions/1
  # DELETE /quiz_questions/1.xml
  def destroy
    @quiz_question = @quiz_page.quiz_questions.find(params[:id])
    @quiz_question.destroy

    respond_to do |format|
      format.html { redirect_to(learning_module_section_quiz_page_quiz_questions_path) }
      format.xml  { head :ok }
    end
  end
end
