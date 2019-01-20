class Draft < ApplicationRecord
  has_secure_token

  validates_presence_of :title, :body
  belongs_to :user

  before_validation :check_title

  private

  def check_title
    if title == ''
      self.title = 'Untitled Draft'
    end
  end

  # def sanitize_body
  #   # Sanitize.fragment(body, Sanitize::Config::RELAXED)
  #   white_list_sanitizer = Rails::Html::WhiteListSanitizer.new
  #   self.body = white_list_sanitizer.sanitize(body, tags: %w(p h1 h2 img blockquote strong em u), attributes: %w(id class src))
  # end

end