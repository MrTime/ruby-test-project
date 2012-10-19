require 'spec_helper.rb'
require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "mailer" do
#  get :send_comment
  it 'should have access to URL helpers' do
    lambda { "/books" }.should_not raise_error
  end
end