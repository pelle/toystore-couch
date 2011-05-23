require 'helper'
describe Toy::Couch::Type do
  uses_constants('User')

  before(:each) do
    User.identity_map_off
    User.send :include, Toy::Couch::Type
    User.attribute(:name, String)
    User.attribute(:state, String)
  end

  describe "revisioning" do
    before(:each) do
      @john = User.create(:name => 'John', :state=>"CA")
    end

    it "performs view" do
      @john.persisted_attributes["type"].should == "User"
    end
  end
end