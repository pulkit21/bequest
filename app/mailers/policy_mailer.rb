class PolicyMailer < ApplicationMailer

  def send_signature_link(insurance)
    # @user = insurance.user
    @insurance = insurance
    mail(to: insurance.user.email, subject: "Sign your life insurance policy")
  end

end
