require 'spec_helper'

describe OmniAuth::FailureEndpoint do
  subject{ OmniAuth::FailureEndpoint }

  context "development" do
    before do
      @rack_env = ENV['RACK_ENV']
      ENV['RACK_ENV'] = 'development'
    end

    it "raises out the error" do
      expect do
        subject.call('omniauth.error' => StandardError.new("Blah"))
      end.to raise_error(StandardError, "Blah")
    end

    it "raises out an OmniAuth::Error if no omniauth.error is set" do
      expect{ subject.call('omniauth.error.type' => 'example') }.to raise_error(OmniAuth::Error, "example")
    end

    after do
      ENV['RACK_ENV'] = @rack_env
    end
  end

  context "non-development" do
    let(:env){ {'omniauth.error.type' => 'invalid_request',
                'omniauth.error.strategy' => ExampleStrategy.new({}) } }
  end
end
