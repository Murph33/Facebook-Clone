class UserMailer < ApplicationMailer

  def notify_new_user user
    @user = user
    mail(to: @user.email, subject: "Signup confirmation for Fakebook")
  end
end
