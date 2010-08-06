require 'spec_helper'

describe "/sms_messages/create" do
  before(:each) do
    render 'sms_messages/create'
  end

  #Delete this example and add some real ones or delete this file
  it "should tell you where to find the file" do
    response.should have_tag('p', %r[Find me in app/views/sms_messages/create])
  end
end
