# This file was generated by the docusign_rest:generate_config rake task.
# You can run 'rake docusign_rest:generate_config' as many times as you need
# to replace the content of this file with a new config.

require 'docusign_rest'

DocusignRest.configure do |config|
  config.username       = Rails.application.secrets.docosign_username
  config.password       = Rails.application.secrets.docosign_password
  config.integrator_key = Rails.application.secrets.docosign_integration_key
  config.account_id     = Rails.application.secrets.docosign_account_id
  #config.endpoint       = 'https://www.docusign.net/restapi'
  #config.api_version    = 'v2'
end

