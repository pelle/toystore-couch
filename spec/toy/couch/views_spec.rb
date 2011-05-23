require 'helper'
describe Toy::Couch::Views do
  uses_constants('User')

  before(:each) do
    User.identity_map_off
    User.attribute(:name, String)
    User.attribute(:state, String)
    User.view_by :state
    User.view_by :name
  end

  describe "revisioning" do
    before(:each) do
      @john = User.create(:name => 'John', :state=>"CA")
      @bill = User.create(:name => 'Bill', :state=>"FL")
      @miguel = User.create(:name => 'Miguel', :state=>"FL")
    end

    it "performs view" do
      all = User.view(:all)
      all.should include(@john)
      all.should include(@bill)
      all.should include(@miguel)
      
      User.view(:by_state, :key=>"FL").should include(@miguel)
      User.view(:by_state, :key=>"FL").should include(@bill)

      User.view(:by_state, :key=>"CA").should include(@john)
      
      User.view(:by_name, :key=>"John").should include(@john)
      
      User.first_from_view(:by_name, "John").should == @john
    end
  end
end