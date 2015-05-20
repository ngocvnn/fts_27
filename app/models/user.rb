class User < ActiveRecord::Base
  before_create :set_default_role
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :exams, dependent: :destroy

  enum role: [:admin, :registered]

  mount_uploader :avatar, AvatarUploader

  validates :name, presence: true
  validate :avatar_size

  def self.send_mail
    User.all.each {|user| UserMailer.notice_exam(user).deliver_now}
  end

  private
  def avatar_size
    if avatar.size > Settings.max_avatar_file_size.megabytes
      errors.add :avatar,
        I18n.t('avatar.failure.big_upload_size', max_file_size: Settings.max_avatar_file_size)
    end
  end

  def set_default_role
    self.role ||= "registered"
  end
end
