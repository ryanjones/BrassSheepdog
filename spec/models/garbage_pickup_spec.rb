require 'spec_helper'

describe GarbagePickup do
  before(:each) do
    @valid_attributes = {
      :entity_id => "value for entity_id",
      :pickup_date => Time.now,
      :zone => "value for zone",
      :day => 1
    }
  end

  it "should create a new instance given valid attributes" do
    GarbagePickup.create!(@valid_attributes)
  end
end
