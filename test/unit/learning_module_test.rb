require 'test_helper'

class LearningModuleTest < ActiveSupport::TestCase
  test "create learning module" do
    lm = LearningModule.new :title => "new module title"
    assert lm.valid?, lm.errors.full_messages
    assert lm.save, lm.errors.full_messages
  end

  test "should test fixtures" do
    obs = LearningModule.find :all
    assert obs.size > 0
    for ob in obs
      assert ob.valid?
    end
  end
end
