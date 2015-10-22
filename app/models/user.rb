class User < ActiveRecord::Base
  attr_reader :password

  validates :email, :password_digest, uniqueness: true, presence: true
  validates :password, length: { minimum: 6, allow_nil: true}

  after_initialize :ensure_session_token, :ensure_activation_token

  has_many :notes

  def self.find_by_credentials(email, password)
    user = User.find_by_email(email)

    return nil unless user

    user.password_digest.is_password?(password) ? user : nil
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def password_digest
    BCrypt::Password.new(super)
  end

  def reset_session_token!
    self.session_token = SecureRandom.urlsafe_base64
    save
  end

  private

  def ensure_session_token
    self.session_token ||= SecureRandom.urlsafe_base64
  end

  def ensure_activation_token
    self.activation_token ||= SecureRandom.urlsafe_base64
  end

end
