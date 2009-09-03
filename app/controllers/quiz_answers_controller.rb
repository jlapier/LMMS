class QuizAnswersController < ApplicationController
  before_filter :login_required, :only => [ :new, :create, :edit, :update, :destroy ]


  # TODO: do we even need this controller????

  # GET /quiz_answers
  # GET /quiz_answers.xml
  def index
    @quiz_answers = QuizAnswer.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @quiz_answers }
    end
  end

  # GET /quiz_answers/1
  # GET /quiz_answers/1.xml
  def show
    @quiz_answer = QuizAnswer.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @quiz_answer }
    end
  end

  # GET /quiz_answers/new
  # GET /quiz_answers/new.xml
  def new
    @quiz_answer = QuizAnswer.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @quiz_answer }
    end
  end

  # GET /quiz_answers/1/edit
  def edit
    @quiz_answer = QuizAnswer.find(params[:id])
  end

  # POST /quiz_answers
  # POST /quiz_answers.xml
  def create
    @quiz_answer = QuizAnswer.new(params[:quiz_answer])

    respond_to do |format|
      if @quiz_answer.save
        flash[:notice] = 'QuizAnswer was successfully created.'
        format.html { redirect_to(@quiz_answer) }
        format.xml  { render :xml => @quiz_answer, :status => :created, :location => @quiz_answer }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @quiz_answer.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /quiz_answers/1
  # PUT /quiz_answers/1.xml
  def update
    @quiz_answer = QuizAnswer.find(params[:id])

    respond_to do |format|
      if @quiz_answer.update_attributes(params[:quiz_answer])
        flash[:notice] = 'QuizAnswer was successfully updated.'
        format.html { redirect_to(@quiz_answer) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @quiz_answer.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /quiz_answers/1
  # DELETE /quiz_answers/1.xml
  def destroy
    @quiz_answer = QuizAnswer.find(params[:id])
    @quiz_answer.destroy

    respond_to do |format|
      format.html { redirect_to(quiz_answers_url) }
      format.xml  { head :ok }
    end
  end
end
