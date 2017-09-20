class PolicyMailer < ApplicationMailer

  def send_signature_link(insurance)
    # @user = insurance.user
    @insurance = insurance
    mail(to: "bequest@mailinator.com", subject: "Sign your life insurance policy")
  end

end
