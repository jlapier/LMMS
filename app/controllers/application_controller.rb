# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time

  include AuthenticatedSystem
  
  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  
  # TODO I'm taking this out until I can figure out how to get an authenticity token 
  # in javascript
  #protect_from_forgery # :secret => '54f6ff4a645bb9014f41a6419371894d'
  
  filter_parameter_logging :password
  before_filter :check_site_status

  private
  def get_learning_module
    @learning_module ||= params[:learning_module_id] ? LearningModule.find(params[:learning_module_id]) : nil
  end

  def get_section
    @section ||= (@learning_module and params[:section_id]) ? @learning_module.sections.find(params[:section_id]) : nil
  end

  def get_quiz_page
    @quiz_page ||= (@section and params[:quiz_page_id]) ? @section.quiz_pages.find(params[:quiz_page_id]) : nil
  end

  def check_site_status
    @have_a_user = User.count > 0
    @have_a_site_page = SitePage.count > 0
    @have_a_module = LearningModule.count > 0
    unless @have_a_user and @have_a_site_page and @have_a_module
      redirect_to intro_site_settings_path
    end
  end
end
