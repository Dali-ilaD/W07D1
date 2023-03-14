


class User < ApplicationRecord

    validates :password_digest,  presence:true
    validates :username, uniqueness:true, presence:true

    before_validation :ensure_session_token
    
    def password=(password)
        @password = password

        self.password_digest = BCrypt::Password.create(password)
    end
    
    def is_password?(password)

        bcrypt_object = BCrypt::Password.new(self.password_digest)

        bcrypt_object.is_password?(password)        

    end

    def self.find_by_credentials(username, password)
        user = User.find_by(username: username)

        if user && user.is_password?(password)
            return user
        else
            return nil
        end

        
    end

    def generate_unique_session_token
        token = SecureRandom::urlsafe_base64
        while User.exists?(session_token: token)
            token = SecureRandom::urlsafe_base64
        end
        token
    end

    def reset_session_token!
        self.session_token = generate_unique_session_token
        self.save!
        self.session_token  
    end

    private

    def ensure_session_token
        self.session_token ||= generate_unique_session_token
    end


end