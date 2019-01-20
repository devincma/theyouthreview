# Preview all emails at http://localhost:3000/rails/mailers/writings_mailer
class WritingsMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/writings_mailer/writing_featured
  def writing_featured
    WritingsMailer.writing_featured
  end

  # Preview this email at http://localhost:3000/rails/mailers/writings_mailer/writing_featured_for_banner
  def writing_featured_for_banner
    WritingsMailer.writing_featured_for_banner
  end

end
