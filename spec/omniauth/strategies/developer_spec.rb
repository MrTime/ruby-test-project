require 'spec_helper'

describe OmniAuth::Strategies::Developer do
  let(:app){ Rack::Builder.new do |b|
    b.use Rack::Session::Cookie
    b.use OmniAuth::Strategies::Developer
    b.run lambda{|env| [200, {}, ['Not Found']]}
  end.to_app }

  context "request phase" do
    before(:each){ get '/auth/developer' }
  end

  context "callback phase" do
    let(:auth_hash){ last_request.env['omniauth.auth'] }

    context "with default options" do
      before do
        post '/auth/developer/callback', :name => 'Example User', :email => 'user@example.com'
      end
    end

    context "with custom options" do
      let(:app){ Rack::Builder.new do |b|
        b.use Rack::Session::Cookie
        b.use OmniAuth::Strategies::Developer, :fields => [:first_name, :last_name], :uid_field => :last_name
        b.run lambda{|env| [200, {}, ['Not Found']]}
      end.to_app }

      before do
        @options = {:uid_field => :last_name, :fields => [:first_name, :last_name]}
        post '/auth/developer/callback', :first_name => 'Example', :last_name => 'User'
      end
    end
  end
end
