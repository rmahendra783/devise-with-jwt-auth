class SendEmailsJob < ApplicationJob
  queue_as :default

  def self.send_email_perameter(user)
    user = User.find(user.id)
    UserMailer.welcome_email(user).deliver_now
  end
end
