# == Schema Information
# Schema version: 20090807161933
#
# Table name: content_pages
#
#  id                        :integer       not null, primary key
#  section_id                :integer       
#  title                     :string(255)   
#  position                  :integer       
#  main_body                 :text          
#  secondary_body            :text          
#  created_at                :datetime      
#  updated_at                :datetime      
#  layout_image_file_name    :string(255)   
#  layout_image_content_type :string(255)   
#  layout_image_file_size    :integer       
#  layout_image_updated_at   :datetime      
#  layout_image_alt_text     :string(255)   
# (end schema)

class ContentPage < ActiveRecord::Base
  belongs_to :section
  validates_presence_of :section_id, :main_body

  has_attached_file :layout_image, :styles => { :original => ["350x425", :jpg], :thumb => ["200x200", :jpg] }

  acts_as_list

  include ActionView::Helpers::TextHelper
  
  def title_in_list
    title.blank? ? truncate(HTML::FullSanitizer.new.sanitize(main_body), :length => 70) : title
  end

  def next_page
    section.content_pages.find :first, :conditions => ['position > ?', position], :select => [:id]
  end

  def prev_page
    section.content_pages.find :first, :conditions => ['position < ?', position], :order => 'position DESC', :select => [:id]
  end
end
