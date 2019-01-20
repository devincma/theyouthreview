class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.granted_staff_access.subject
  #
  def granted_staff_access(user)
    @user = user
    mail(to: @user.email, subject: "You're now a staff on The Youth Review")
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.named_star_writer.subject
  #
  def named_star_writer(user)
    @user = user
    mail(to: @user.email, subject: "You're now a star writer on The Youth Review")
  end

  def writing_approved(user)
    @user = user
    mail(to: @user.email, subject: 'Your first writing has been approved and published!')
  end

end
