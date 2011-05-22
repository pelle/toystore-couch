require 'helper'
require 'toy/couch'
describe Toy::Couch::Persistence do
  uses_constants('User')

  before(:each) do
    User.identity_map_off
    User.attribute(:name, String)
    User.attribute(:bio, String)
  end

  describe "revisioning" do
    before(:each) do
      @user = User.create(:name => 'John')
    end

    it "performs update" do
      @user.name = "Frank"
      @user.save
      @user.reload
      @user.name.should == 'Frank'
    end
  end
end