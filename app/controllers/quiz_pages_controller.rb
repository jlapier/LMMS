class QuizPagesController < ApplicationController
  before_filter :get_learning_module
  before_filter :get_section
  before_filter :login_required, :only => [ :new, :create, :edit, :update, :destroy ]
  
  # GET /quiz_pages
  # GET /quiz_pages.xml
  def index
    @quiz_pages = @section.quiz_pages

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @quiz_pages }
    end
  end

  # GET /quiz_pages/1
  # GET /quiz_pages/1.xml
  def show
    @quiz_page = @section.quiz_pages.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @quiz_page }
    end
  end

  # GET /quiz_pages/new
  # GET /quiz_pages/new.xml
  def new
    @quiz_page = QuizPage.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @quiz_page }
    end
  end

  # GET /quiz_pages/1/edit
  def edit
    @quiz_page = @section.quiz_pages.find(params[:id])
  end

  # POST /quiz_pages
  # POST /quiz_pages.xml
  def create
    @quiz_page = QuizPage.new(params[:quiz_page])
    @quiz_page.section = @section
    
    respond_to do |format|
      if @quiz_page.save
        flash[:notice] = 'Quiz Page was successfully created.'
        format.html { redirect_to learning_module_section_quiz_page_path(@learning_module, @section, @quiz_page) }
        format.xml  { render :xml => @quiz_page, :status => :created, :location => @quiz_page }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @quiz_page.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /quiz_pages/1
  # PUT /quiz_pages/1.xml
  def update
    @quiz_page = @section.quiz_pages.find(params[:id])

    respond_to do |format|
      if @quiz_page.update_attributes(params[:quiz_page])
        flash[:notice] = 'Quiz Page was successfully updated.'
        format.html { redirect_to learning_module_section_quiz_page_path(@learning_module, @section, @quiz_page) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @quiz_page.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /quiz_pages/1
  # DELETE /quiz_pages/1.xml
  def destroy
    @quiz_page = @section.quiz_pages.find(params[:id])
    @quiz_page.destroy

    respond_to do |format|
      format.html { redirect_to(learning_module_section_quiz_pages_path(@learning_module, @section)) }
      format.xml  { head :ok }
    end
  end


  def score
    @quiz_page = @section.quiz_pages.find(params[:id])
    @quiz_questions = @quiz_page.quiz_questions
    if session[:answer_hash] and session[:answer_hash][@quiz_page.id] and session[:answer_hash][@quiz_page.id].size == @quiz_questions.size
      @score = @quiz_page.score(session[:answer_hash][@quiz_page.id])
    else
      flash[:warning] = "Please complete this quiz before examining your score."
      redirect_to learning_module_section_quiz_page_path(@learning_module, @section, @quiz_page)
    end
  end
end
