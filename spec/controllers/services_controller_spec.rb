require 'spec_helper'

describe ServicesController do
	
  before(:each) do
		OmniAuth.config.test_mode = true
		OmniAuth.config.mock_auth[:twitter] = {
		    'uid' => '12345',
		    'provider' => 'twitter',
		    'info' => {
		      'name' => 'Bob'
		    }
		  }
	end
  
  describe "GET 'new'" do
    it "redirectes users to authentication" do
      get 'create'
      assert_redirected_to '/users/sign_in'
    end
  end
    
   describe "success" do
      before(:each) do
        request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:twitter]
      end
end
end
