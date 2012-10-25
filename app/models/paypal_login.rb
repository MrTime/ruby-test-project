class PaypalLogin < Settingslogic
  source "#{Rails.root}/config/paypal_login.yml"
  namespace Rails.env
  suppress_errors Rails.env.production?
end
