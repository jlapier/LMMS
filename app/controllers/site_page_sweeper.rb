class SitePageSweeper < ActionController::Caching::Sweeper
  observe SitePage

  def after_update(site_page)
    expire_fragment :controller => '/site_pages', :action => :show, :id => site_page.id
  end

end