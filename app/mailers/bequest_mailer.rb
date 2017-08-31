class BequestMailer < Devise::Mailer

  helper :application # gives access to all helpers defined within `application_helper`.
  include Devise::Controllers::UrlHelpers # Optional. eg. `confirmation_url`
  default template_path: 'devise/mailer' # to make sure that you mailer uses the devise views

  def confirmation_instructions(record, token, opts={})
    if record.active_zipcode?
      opts[:subject] = "Welcome #{record.full_name}, confirm your BequestLife account"
    else
      opts[:subject] = "No Coverage for #{record.zipcode} zipcode"
    end
    super
  end

end
