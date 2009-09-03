require 'test_helper'

class SectionTest < ActiveSupport::TestCase
  def setup
    @learning_module = LearningModule.find :first
    @atts = { :learning_module => @learning_module, :title => "Test title" }
  end

  test "should create section" do
    sec = Section.new @atts
    assert sec.valid?, sec.errors.full_messages
    assert sec.save, sec.errors.full_messages
  end


  test "should test fixtures" do
    obs = Section.find :all
    assert obs.size > 0
    for ob in obs
      assert ob.valid?
    end
  end
end
