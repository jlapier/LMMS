# == Schema Information
# Schema version: 20090807161933
#
# Table name: sections
#
#  id                        :integer       not null, primary key
#  learning_module_id        :integer       
#  position                  :integer       
#  title                     :string(255)   
#  layout_image_file_name    :string(255)   
#  layout_image_content_type :string(255)   
#  layout_image_file_size    :integer       
#  layout_image_updated_at   :datetime      
#  layout_image_alt_text     :string(255)   
# (end schema)

class Section < ActiveRecord::Base
  belongs_to :learning_module
  has_many :content_pages, :order => 'position'
  has_many :quiz_pages, :order => 'position'

  validates_presence_of :learning_module_id, :title
  validates_uniqueness_of :title, :scope => :learning_module_id

  acts_as_list

  has_attached_file :layout_image, :styles => { :original => ["350x425", :jpg], :thumb => ["200x200", :jpg] }
end
