# == Schema Information
# Schema version: 20090807161933
#
# Table name: site_pages
#
#  id                        :integer       not null, primary key
#  title                     :string(255)   
#  position                  :integer       
#  body                      :text          
#  layout_image_file_name    :string(255)   
#  layout_image_content_type :string(255)   
#  layout_image_file_size    :integer       
#  layout_image_updated_at   :datetime      
#  layout_image_alt_text     :string(255)   
#  created_at                :datetime      
#  updated_at                :datetime      
# (end schema)
class SitePage < ActiveRecord::Base
  validates_presence_of :title, :body

  has_attached_file :layout_image, :styles => { :original => ["350x425", :jpg], :thumb => ["200x200", :jpg] }

  acts_as_list
end
