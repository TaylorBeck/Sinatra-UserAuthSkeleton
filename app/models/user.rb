class User < ActiveRecord::Base
  validates :email, presence: true, uniqueness: true
  validates :hashed_password, presence: true
  validates :first_name, :last_name, presence: true
  validate :password_present?

  def self.authenticate(email, password)
    @user = User.find_by(email: email)
    return @user if @user && @user.password == password
    nil
  end

  def password
    @password ||= BCrypt::Password.new(hashed_password)
  end

  def password=(new_password)
    @password = BCrypt::Password.create(new_password)
    self.hashed_password = @password
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  private
  def password_blank?
    password == ""
  end

  def password_present?
    if password_blank?
      errors.add :password, 'cannot be blank.'
    end
  end

end
