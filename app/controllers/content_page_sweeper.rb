class ContentPageSweeper < ActionController::Caching::Sweeper
  observe ContentPage

  def after_update(content_page)
    expire_fragment :controller => '/content_pages', :action => :show, :id => content_page.id
  end

end