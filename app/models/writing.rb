class Writing < ApplicationRecord

  extend FriendlyId
  friendly_id :title, use: :slugged

  belongs_to :user
  validates_presence_of :title, :body, :tag_list

  is_impressionable

  acts_as_taggable
  acts_as_taggable_on :topics

  before_save :sanitize_body
  # after_save :send_status_change_emails

  private

  def sanitize_body
    # Sanitize.fragment(body, Sanitize::Config::RELAXED)
    white_list_sanitizer = Rails::Html::WhiteListSanitizer.new
    self.body = white_list_sanitizer.sanitize(body, tags: %w(p h1 h2 a img br blockquote strong em u ul ol li hr), attributes: %w(id class src href style target rel))
    self.body = body.gsub('https://s3-us-west-2.amazonaws.com/theyouthreview/writings-upload%2F', 'https://d1cndlyhl5fqed.cloudfront.net/writings-upload/')
    if user.is_trusted
      self.is_approved = true
    end
  end

  def send_status_change_emails
    if is_featured_was == false && is_featured_changed?
      WritingsMailer.writing_featured(self).deliver_later
    elsif is_featured_today_was == false && is_featured_today_changed?
      WritingsMailer.writing_featured_for_banner(self).deliver_later
    end
  end

end
