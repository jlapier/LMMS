class SitePagesController < ApplicationController
  before_filter :login_required, :only => [ :new, :create, :edit, :update, :destroy ]
  skip_before_filter :check_site_status, :except => [ :index, :show ]
  cache_sweeper :site_page_sweeper, :only => [ :update ]
  
  def index
    @site_pages = SitePage.find :all, :select => 'title, position, id', :order => 'position'
  end

  # GET /site_pages/1
  # GET /site_pages/1.xml
  def show
    unless fragment_exist? :action => :show, :id => params[:id]
      @site_page = SitePage.find(params[:id])
    end
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => (@site_page || SitePage.find(params[:id])) }
    end
  end

  # GET /site_pages/new
  # GET /site_pages/new.xml
  def new
    @site_page = SitePage.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @site_page }
    end
  end

  # GET /site_pages/1/edit
  def edit
    @site_page = SitePage.find(params[:id])
  end

  # POST /site_pages
  # POST /site_pages.xml
  def create
    @site_page = SitePage.new(params[:site_page])

    respond_to do |format|
      if @site_page.save
        flash[:notice] = "Page <em>#{@site_page.title}</em> was successfully created."
        format.html { redirect_to @site_page }
        format.xml  { render :xml => @site_page, :status => :created, :location => @site_page }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @site_page.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /site_pages/1
  # PUT /site_pages/1.xml
  def update
    @site_page = SitePage.find(params[:id])

    respond_to do |format|
      if @site_page.update_attributes(params[:site_page])
        flash[:notice] = "Page <em>#{@site_page.title}</em> was successfully updated."
        format.html { redirect_to @site_page }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @site_page.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /site_pages/1
  # DELETE /site_pages/1.xml
  def destroy
    @site_page = SitePage.find(params[:id])
    @site_page.destroy
    flash[:notice] = "Page titled <em>#{@site_page.title}</em> was deleted."
    
    respond_to do |format|
      format.html { redirect_to site_pages_path }
      format.xml  { head :ok }
    end
  end
end
