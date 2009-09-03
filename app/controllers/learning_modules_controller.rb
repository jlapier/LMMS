class LearningModulesController < ApplicationController
  before_filter :login_required, :only => [ :new, :create, :edit, :update, :destroy ]
  skip_before_filter :check_site_status, :except => [ :index, :show ]

  # GET /learning_modules
  # GET /learning_modules.xml
  def index
    @learning_modules = LearningModule.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @learning_modules }
    end
  end

  # GET /learning_modules/1
  # GET /learning_modules/1.xml
  def show
    @learning_module = LearningModule.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @learning_module }
    end
  end

  # GET /learning_modules/new
  # GET /learning_modules/new.xml
  def new
    @learning_module = LearningModule.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @learning_module }
    end
  end

  # GET /learning_modules/1/edit
  def edit
    @learning_module = LearningModule.find(params[:id])
  end

  # POST /learning_modules
  # POST /learning_modules.xml
  def create
    @learning_module = LearningModule.new(params[:learning_module])

    respond_to do |format|
      if @learning_module.save
        flash[:notice] = 'Learning Module was successfully created.'
        format.html { redirect_to(@learning_module) }
        format.xml  { render :xml => @learning_module, :status => :created, :location => @learning_module }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @learning_module.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /learning_modules/1
  # PUT /learning_modules/1.xml
  def update
    @learning_module = LearningModule.find(params[:id])

    respond_to do |format|
      if @learning_module.update_attributes(params[:learning_module])
        if params[:drop_image] == "1"
          @learning_module.layout_image = nil
          @learning_module.save
        end
        flash[:notice] = 'Learning Module was successfully updated.'
        format.html { redirect_to(@learning_module) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @learning_module.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /learning_modules/1
  # DELETE /learning_modules/1.xml
  def destroy
    @learning_module = LearningModule.find(params[:id])
    @learning_module.destroy

    respond_to do |format|
      format.html { redirect_to(learning_modules_url) }
      format.xml  { head :ok }
    end
  end
end
