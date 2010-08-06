require 'spec_helper'

describe SmsMessagesController do

  #Delete these examples and add some real ones
  it "should use SmsMessagesController" do
    controller.should be_an_instance_of(SmsMessagesController)
  end


  describe "GET 'new'" do
    it "should be successful" do
      get 'new'
      response.should be_success
    end
  end

  describe "GET 'create'" do
    it "should be successful" do
      get 'create'
      response.should be_success
    end
  end
end
