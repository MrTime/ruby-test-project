require 'spec_helper'

def make_env(path = '/auth/test', props = {})
  {
    'REQUEST_METHOD' => 'GET',
    'PATH_INFO' => path,
    'rack.session' => {},
    'rack.input' => StringIO.new('test=true')
  }.merge(props)
end

describe OmniAuth::Strategy do
  let(:app){ lambda{|env| [404, {}, ['Awesome']]}}
  let(:fresh_strategy){ c = Class.new; c.send :include, OmniAuth::Strategy; c}

  describe ".default_options" do
    it "is inherited from a parent class" do
      superklass = Class.new
      superklass.send :include, OmniAuth::Strategy
      superklass.configure do |c|
        c.foo = 'bar'
      end

      klass = Class.new(superklass)
      expect(klass.default_options.foo).to eq('bar')
    end
  end

  describe ".configure" do
    subject { klass = Class.new; klass.send :include, OmniAuth::Strategy; klass }
    it "takes a block and allow for default options setting" do
      subject.configure do |c|
        c.wakka = 'doo'
      end
      expect(subject.default_options["wakka"]).to eq("doo")
    end

    it "takes a hash and deep merge it" do
      subject.configure :abc => {:def => 123}
      subject.configure :abc => {:hgi => 456}
      expect(subject.default_options['abc']).to eq({'def' => 123, 'hgi' => 456})
    end
  end

  describe ".option" do
    subject { klass = Class.new; klass.send :include, OmniAuth::Strategy; klass }
    it "sets a default value" do
      subject.option :abc, 123
      expect(subject.default_options.abc).to eq(123)
    end

    it "sets the default value to nil if none is provided" do
      subject.option :abc
      expect(subject.default_options.abc).to be_nil
    end
  end

  describe ".args" do
    subject{ c = Class.new; c.send :include, OmniAuth::Strategy; c }
    it "sets args to the specified argument if there is one" do
      subject.args [:abc, :def]
      expect(subject.args).to eq([:abc, :def])
    end

    it "is inheritable" do
      subject.args [:abc, :def]
      c = Class.new(subject)
      expect(c.args).to eq([:abc, :def])
    end
  end

  context "fetcher procs" do
    subject{ fresh_strategy }
    %w(uid info credentials extra).each do |fetcher|
      describe ".#{fetcher}" do
        it "sets and retrieve a proc" do
          proc = lambda{ "Hello" }
          subject.send(fetcher, &proc)
          expect(subject.send(fetcher)).to eq(proc)
        end
      end
    end
  end

  context "fetcher stacks" do
    subject{ fresh_strategy }
    %w(uid info credentials extra).each do |fetcher|
      describe ".#{fetcher}_stack" do
        it "is an array of called ancestral procs" do
          fetchy = Proc.new{ "Hello" }
          subject.send(fetcher, &fetchy)
          expect(subject.send("#{fetcher}_stack", subject.new(app))).to eq(["Hello"])
        end
      end
    end
  end

  %w(request_phase).each do |abstract_method|
    context "#{abstract_method}" do
      it "raises a NotImplementedError" do
        strat = Class.new
        strat.send :include, OmniAuth::Strategy
        expect{strat.new(app).send(abstract_method) }.to raise_error(NotImplementedError)
      end
    end
  end

  describe "#auth_hash" do
    subject do
      klass = Class.new
      klass.send :include, OmniAuth::Strategy
      klass.option :name, 'auth_hasher'
      klass
    end
    let(:instance){ subject.new(app) }

    it "calls through to uid and info" do
      instance.should_receive :uid
      instance.should_receive :info
      instance.auth_hash
    end

    it "returns an AuthHash" do
      instance.stub!(:uid).and_return('123')
      instance.stub!(:info).and_return(:name => 'Hal Awesome')
      hash = instance.auth_hash
      expect(hash).to be_kind_of(OmniAuth::AuthHash)
      expect(hash.uid).to eq('123')
      expect(hash.info.name).to eq('Hal Awesome')
    end
  end

  describe "#initialize" do
    context "options extraction" do
    context "custom args" do
      subject{ c = Class.new; c.send :include, OmniAuth::Strategy; c }
      it "sets options based on the arguments if they are supplied" do
        subject.args [:abc, :def]
        s = subject.new app, 123, 456
        expect(s.options[:abc]).to eq(123)
        expect(s.options[:def]).to eq(456)
      end
    end
  end

  describe "#call" do
    it "duplicates and calls" do
      klass = Class.new
      klass.send :include, OmniAuth::Strategy
      instance = klass.new(app)
      instance.should_receive(:dup).and_return(instance)
      instance.call({'rack.session' => {}})
    end
  end

  describe "#callback_phase" do
    subject{ k = Class.new; k.send :include, OmniAuth::Strategy; k.new(app) }

    it "sets the auth hash" do
      env = make_env
      subject.stub!(:env).and_return(env)
      subject.stub!(:auth_hash).and_return("AUTH HASH")
      subject.callback_phase
      expect(env['omniauth.auth']).to eq("AUTH HASH")
    end
  end

  describe "#uid" do
    subject{ fresh_strategy }
    it "is the current class's uid if one exists" do
      subject.uid{ "Hi" }
      expect(subject.new(app).uid).to eq("Hi")
    end

    it "inherits if it can" do
      subject.uid{ "Hi" }
      c = Class.new(subject)
      expect(c.new(app).uid).to eq("Hi")
    end
  end

  %w(info credentials extra).each do |fetcher|
    subject{ fresh_strategy }
    it "is the current class's proc call if one exists" do
      subject.send(fetcher){ {:abc => 123} }
      expect(subject.new(app).send(fetcher)).to eq({:abc => 123})
    end

    it "inherits by merging with preference for the latest class" do
      subject.send(fetcher){ {:abc => 123, :def => 456} }
      c = Class.new(subject)
      c.send(fetcher){ {:abc => 789} }
      expect(c.new(app).send(fetcher)).to eq({:abc => 789, :def => 456})
    end
  end

  describe "#call" do
    let(:strategy){ ExampleStrategy.new(app, @options || {}) }



    context "dynamic paths" do
      it "provides a custom callback path if request_path evals to a string" do
        strategy_instance = fresh_strategy.new(nil, :request_path => lambda{|env| "/auth/boo/callback/22" })
        expect(strategy_instance.callback_path).to eq('/auth/boo/callback/22')
      end
    end

    context "custom prefix" do
      before do
        @options = {:path_prefix => '/wowzers'}
      end

      context "callback_url" do
      end
    end

    context "request method restriction" do
      before do
        OmniAuth.config.allowed_request_methods = [:post]
      end

      after do
        OmniAuth.config.allowed_request_methods = [:get, :post]
      end
    end

    context "receiving an OPTIONS request" do
      shared_examples_for "an OPTIONS request" do
      end

      context "to the request path" do
        let(:response) { strategy.call(make_env('/auth/test', 'REQUEST_METHOD' => 'OPTIONS')) }
        it_behaves_like "an OPTIONS request"
      end

      context "to the request path" do
        let(:response) { strategy.call(make_env('/auth/test/callback', 'REQUEST_METHOD' => 'OPTIONS')) }
        it_behaves_like "an OPTIONS request"
      end

      context "to some other path" do
      end
    end

    context "test mode" do
      let(:app) do
        # In test mode, the underlying app shouldn't be called on request phase.
        lambda { |env| [404, {"Content-Type" => "text/html"}, []] }
      end

      before do
        OmniAuth.config.test_mode = true
      end


      it "redirects on failure" do
        response = OmniAuth.config.on_failure.call(make_env('/auth/test', 'omniauth.error.type' => 'error'))
        expect(response[0]).to eq(302)
        expect(response[1]['Location']).to eq('/auth/failure?message=error')
      end

      it "respects SCRIPT_NAME (a.k.a. BaseURI) on failure" do
        response = OmniAuth.config.on_failure.call(make_env('/auth/test', 'SCRIPT_NAME' => '/sub_uri', 'omniauth.error.type' => 'error'))
        expect(response[0]).to eq(302)
        expect(response[1]['Location']).to eq('/sub_uri/auth/failure?message=error')
      end


      after do
        OmniAuth.config.test_mode = false
      end
    end

    context "custom full_host" do
      before do
        OmniAuth.config.test_mode = true
      end

      after do
        OmniAuth.config.test_mode = false
      end
    end
  end

  context "setup phase" do
    before do
      OmniAuth.config.test_mode = true
    end

    context "when options[:setup] = true" do
      let(:strategy){ ExampleStrategy.new(app, :setup => true) }
      let(:app){lambda{|env| env['omniauth.strategy'].options[:awesome] = 'sauce' if env['PATH_INFO'] == '/auth/test/setup'; [404, {}, 'Awesome'] }}

    end

    context "when options[:setup] is an app" do
      let(:setup_proc) do
        Proc.new do |env|
          env['omniauth.strategy'].options[:awesome] = 'sauce'
        end
      end

      let(:strategy){ ExampleStrategy.new(app, :setup => setup_proc) }
    end

    after do
      OmniAuth.config.test_mode = false
    end
  end
end
end