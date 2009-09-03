class SectionsController < ApplicationController
  before_filter :get_learning_module
  before_filter :login_required, :only => [ :new, :create, :edit, :update, :destroy ]
  
  # GET /sections
  # GET /sections.xml
  def index
    redirect_to @learning_module
  end

  # GET /sections/1
  # GET /sections/1.xml
  def show
    @section = @learning_module.sections.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @section }
    end
  end

  # GET /sections/new
  # GET /sections/new.xml
  def new
    @section = Section.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @section }
    end
  end

  # GET /sections/1/edit
  def edit
    @section = @learning_module.sections.find(params[:id])
  end

  # POST /sections
  # POST /sections.xml
  def create
    @section = Section.new(params[:section])
    @section.learning_module = @learning_module

    respond_to do |format|
      if @section.save
        flash[:notice] = 'Section was successfully created.'
        format.html { redirect_to learning_module_section_path(@learning_module, @section) }
        format.xml  { render :xml => @section, :status => :created, :location => @section }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @section.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /sections/1
  # PUT /sections/1.xml
  def update
    @section = @learning_module.sections.find(params[:id])

    respond_to do |format|
      if @section.update_attributes(params[:section])
        flash[:notice] = 'Section was successfully updated.'
        format.html { redirect_to learning_module_section_path(@learning_module, @section) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @section.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /sections/1
  # DELETE /sections/1.xml
  def destroy
    @section = @learning_module.sections.find(params[:id])
    @section.destroy

    respond_to do |format|
      format.html { redirect_to @learning_module }
      format.xml  { head :ok }
    end
  end
end
