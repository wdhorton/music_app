class User < ActiveRecord::Base
  attr_reader :password

  validates :email, :password_digest, uniqueness: true, presence: true
  validates :password, length: { minimum: 6, allow_nil: true}

  # before_validation :ensure_session_token

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def password_digest
    BCrypt::Password.new(super)
  end

  

  private

  # def ensure_session_token
  #
  # end


end
