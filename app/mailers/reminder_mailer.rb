class ReminderMailer < ApplicationMailer

  def send_form_complete_link(insurance)
    @insurance = insurance
    mail(to: insurance.user.email, subject: "Please complete your form.")
  end
end
