# == Schema Information
# Schema version: 20090807161933
#
# Table name: learning_modules
#
#  id                        :integer       not null, primary key
#  title                     :string(255)   
#  position                  :integer       
#  layout_image_file_name    :string(255)   
#  layout_image_content_type :string(255)   
#  layout_image_file_size    :integer       
#  layout_image_updated_at   :datetime      
#  layout_image_alt_text     :string(255)   
#  description               :text          
# (end schema)
class LearningModule < ActiveRecord::Base
  has_many :sections, :order => 'position'

  validates_presence_of :title

  has_attached_file :layout_image, :styles => { :original => ["350x425", :jpg], :thumb => ["200x200", :jpg] }

end
