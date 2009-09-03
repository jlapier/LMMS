require 'test_helper'

class ContentPageTest < ActiveSupport::TestCase
  def setup
    @section = Section.find :first
    @atts = { :section => @section, :title => "Test title", :main_body => "Test body <em>yeah</em>" }
  end

  test "should create content page" do
    cp = ContentPage.new @atts
    assert cp.valid?, cp.errors.full_messages
    assert cp.save, cp.errors.full_messages
  end

  test "should provide truncated sanitized body as title if no title present" do
    cp = ContentPage.new @atts
    assert_equal "Test title", cp.title_in_list
    cp = ContentPage.new @atts.merge( { :title => '' } )
    assert_equal "Test body yeah", cp.title_in_list
  end

  test "should do next and prev pages" do
    cpA = ContentPage.create @atts.merge( { :title => "Page A" })
    cpB = ContentPage.create @atts.merge( { :title => "Page B" })
    assert_equal cpB, cpA.next_page
    assert_equal cpA, cpB.prev_page
  end


  test "should test fixtures" do
    obs = ContentPage.find :all
    assert obs.size > 0
    for ob in obs
      assert ob.valid?
    end
  end
end
