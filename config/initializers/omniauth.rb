Rails.application.config.middleware.use OmniAuth::Builder do  
  provider :facebook, '162049897176776', 'bf148e32dc423259a3235f6016dc80e3'
  provider :twitter, 'fjTEqP7CRu4Tb3GW4hb7hA', 'DSOosZrPcfhtKXe2L9CLZlstJCpu9hcQ9blf354fI'
  provider :openid, :store => OpenID::Store::Filesystem.new('/tmp'), :name => 'openid'
  provider :openid, :store => OpenID::Store::Filesystem.new('/tmp'), :name => 'google', :identifier => 'https://www.google.com/accounts/o8/id'
  end