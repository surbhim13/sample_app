class User < ActiveRecord::Base
	before_save { self.email = email.downcase }
	before_create :create_remember_token
	validates :name,  presence: true, length: { maximum: 50 } , if: :on_profile_step?
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  	validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }, if: :on_profile_step?
    has_secure_password
    validates :password, length: { minimum: 6 }, if: :on_profile_step?

    validates :company, presence: true, if: :on_business_info_step?


    def User.new_remember_token
	    SecureRandom.urlsafe_base64
	  end

    def User.encrypt(token)
      Digest::SHA1.hexdigest(token.to_s)
    end

    def active?
      status == 'active'
    end

    def on_profile_step?
      status.include?('profile') || active? if !status.nil?
    end

    def on_business_info_step?
        status.include?('business') || active? if !status.nil?
    end

  private

    def create_remember_token
      self.remember_token = User.encrypt(User.new_remember_token)
    end
end
