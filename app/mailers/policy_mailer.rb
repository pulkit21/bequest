class PolicyMailer < ApplicationMailer

  def send_signature_link(insurance)
    # @user = insurance.user
    @insurance = insurance
    mail(to: "bequest@mailinator.com", subject: "Signature Request for policy")
  end

end
