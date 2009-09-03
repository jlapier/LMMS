class ContentPagesController < ApplicationController
  before_filter :get_learning_module
  before_filter :get_section
  before_filter :login_required, :only => [ :new, :create, :edit, :update, :destroy ]
  cache_sweeper :content_page_sweeper, :only => [ :update ]

  # GET /content_pages
  # GET /content_pages.xml
  def index
    redirect_to learning_module_section_path(@learning_module, @section)
  end

  # GET /content_pages/1
  # GET /content_pages/1.xml
  def show
    unless fragment_exist? :action => :show, :id => params[:id]
      @content_page = @section.content_pages.find(params[:id])
    end

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => (@content_page || @section.content_pages.find(params[:id])) }
    end
  end

  # GET /content_pages/new
  # GET /content_pages/new.xml
  def new
    @content_page = ContentPage.new :section => @section

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @content_page }
    end
  end

  # GET /content_pages/1/edit
  def edit
    @content_page = @section.content_pages.find(params[:id])
  end

  # POST /content_pages
  # POST /content_pages.xml
  def create
    @content_page = @section.content_pages.new(params[:content_page])
    @content_page.section = @section
    
    respond_to do |format|
      if @content_page.save
        flash[:notice] = 'Page was successfully created.'
        format.html { redirect_to learning_module_section_content_page_path(@learning_module, @section, @content_page) }
        format.xml  { render :xml => @content_page, :status => :created, :location => @content_page }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @content_page.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /content_pages/1
  # PUT /content_pages/1.xml
  def update
    @content_page = @section.content_pages.find(params[:id])

    respond_to do |format|
      if @content_page.update_attributes(params[:content_page])
        flash[:notice] = 'Page was successfully updated.'
        format.html { redirect_to learning_module_section_content_page_path(@learning_module, @section, @content_page) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @content_page.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /content_pages/1
  # DELETE /content_pages/1.xml
  def destroy
    @content_page = @section.content_pages.find(params[:id])
    @content_page.destroy

    respond_to do |format|
      format.html { redirect_to learning_module_section_path(@learning_module, @section) }
      format.xml  { head :ok }
    end
  end
end
