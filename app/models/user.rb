class User < ApplicationRecord

  extend FriendlyId
  friendly_id :slug_candidates, use: :slugged

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :writings, dependent: :destroy
  has_many :drafts, dependent: :destroy

  mount_uploader :avatar, AvatarUploader
  mount_uploader :cover, CoverUploader

  validates_presence_of :first_name, :last_name

  geocoded_by :country
  after_validation :geocode, if: :country_changed?

  after_save :set_writings

  def slug_candidates
    [[:first_name, :last_name]]
  end

  private

  def set_writings
    if self.is_trusted
      self.writings.update_all(is_approved: true)
    else
      self.writings.update_all(is_approved: false)
    end
  end

  def send_status_change_emails
    if is_staff_was == false && is_staff_changed?
      UserMailer.granted_staff_access(self).deliver_later
      if is_star_writer_was == false && is_star_writer_changed?
        UserMailer.named_star_writer(self).deliver_later
      end
    elsif is_star_writer_was == false && is_star_writer_changed?
      UserMailer.named_star_writer(self).deliver_later
      if is_staff_was == false && is_staff_changed?
        UserMailer.granted_staff_access(self).deliver_later
      end
    end

    if is_trusted_was == false && is_trusted_changed?
      UserMailer.writing_approved(self).deliver_later
    end
  end

end
