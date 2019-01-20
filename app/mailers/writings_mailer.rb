class WritingsMailer < ApplicationMailer
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.writings_mailer.writing_featured.subject
  #
  def writing_featured(writing)
    @writing = writing
    mail(to: @writing.user.email, subject: 'Your writing is featured!')
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.writings_mailer.writing_featured_for_banner.subject
  #
  def writing_featured_for_banner(writing)
    @writing = writing
    mail(to: @writing.user.email, subject: 'Your writing is featured for banner!')
  end
end
