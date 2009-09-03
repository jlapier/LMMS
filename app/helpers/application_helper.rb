# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def random_background_image_path
    Dir.chdir("#{RAILS_ROOT}/public/images")
    images = Dir['backgrounds/*']
    image = images[rand(images.size)]
    image_path(image)
  end

  def site_title
    @site_title ||= SiteSetting.read_setting('site title') || "Learning Modules"
  end

  def site_logo
    @site_logo ||= SiteSetting.read_setting('site logo') || "GenericLogo.png"
  end

  def site_footer
    @site_footer ||= SiteSetting.read_setting('site footer') ||
      "Content on this site is the copyright of the owners of #{request.host} and is provided as-is without warranty."
  end

  def page_title
    if @learning_module
      out = "#{@learning_module.title}"
    else
      out = site_title
    end
    out += ": #{@section.title}" if @section
    out += ": #{@content_page.title_in_list}" if @content_page
    out += ": #{@quiz_page.title_in_list}" if @quiz_page
    out += ": #{@site_page.title}" if @site_page
    out
  end

  def modules_for_menu
    @modules_for_menu ||= LearningModule.find :all, :select => 'id, title'
  end

  def sections_for_menu
    @sections_for_menu ||= @learning_module ? @learning_module.sections.find(:all, :select => 'id, title', :order => 'position') : []
  end

  def quizzes_for_menu
    @quizzes_for_menu ||= @section ? @section.quiz_pages.find(:all, :select => 'id, title', :order => 'position') : []
  end

  def site_pages_for_menu
    @site_pages_for_menu ||= SitePage.find(:all, :select => 'id, title', :order => 'position')
  end

  def images_list
    Dir[File.join(RAILS_ROOT, 'public', 'images', "*.{png,jpg,gif}")].map { |f| File.basename f }.sort
  end
end
