# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/user_mailer/granted_staff_access
  def granted_staff_access
    UserMailer.granted_staff_access
  end

  # Preview this email at http://localhost:3000/rails/mailers/user_mailer/named_star_writer
  def named_star_writer
    UserMailer.named_star_writer
  end

end
