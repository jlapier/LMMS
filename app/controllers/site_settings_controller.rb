class SiteSettingsController < ApplicationController
  before_filter :login_required, :only => [ :new, :create, :edit, :update, :destroy ]
  skip_before_filter :check_site_status, :except => [ :index, :show ]


  def intro
    @have_a_user = User.count > 0
    @have_a_site_page = SitePage.count > 0
    @have_a_module = LearningModule.count > 0
  end

  def update_site_settings
    SiteSetting.write_setting 'site title', params[:site_title]
    SiteSetting.write_setting 'site logo', params[:site_logo]
    SiteSetting.write_setting 'site footer', params[:site_footer]
    flash[:notice] = "Site configuration updated."
    redirect_to :action => :index
  end

end
