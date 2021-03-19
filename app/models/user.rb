class User < ApplicationRecord
    has_many :microposts, dependent: :destroy
    has_many :haikus, dependent: :destroy
    has_many :haiku_comments, dependent: :destroy
    has_many :challenges, dependent: :destroy
    has_many :challenge_users
    has_many :haiku_reactions, dependent: :destroy

    has_many :daily_challenges, dependent: :destroy
    has_many :active_relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
    has_many :passive_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
    has_many :following, through: :active_relationships, source: :followed
    has_many :followers, through: :passive_relationships, source: :follower
    has_many :comments, dependent: :destroy
    has_many :reactions, dependent: :destroy
    
    attr_accessor :remember_token, :activation_token, :reset_token
    before_save :downcase_email
    before_create :create_activation_digest
    validates :name, presence: true
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }, uniqueness: true
    has_secure_password
    validates :password, presence: true, length: { minimum:6 }, allow_nil: true

    # Returns the hash digest of the given string.
    
        #returns the hash digest of the given string
    def User.digest(string)
        cost = ActiveModel::SecurePassword.min_cost ?
        BCrypt::Engine::MIN_COST :
        BCrypt::Engine.cost
        BCrypt::Password.create(string, cost: cost)
    end
    # Returns a random token.
    def User.new_token
        SecureRandom.urlsafe_base64
    end
    
    def remember
        self.remember_token = User.new_token
        update_attribute(:remember_digest, User.digest(remember_token))
    end
    # def authenticated?(remember_token)
    #     return false if remember_digest.nil?
    #     BCrypt::Password.new(remember_digest).is_password?(remember_token)
    # end
    def authenticated?(attribute, token)
        digest = send("#{attribute}_digest")
        return false if digest.nil?
        BCrypt::Password.new(digest).is_password?(token)
    end
    # Forgets a user.
    def forget
        update_attribute(:remember_digest, nil)
    end
    # Activates an account.
    def create_reset_digest
        self.reset_token = User.new_token
        update_attribute(:reset_digest, User.digest(reset_token))
        update_attribute(:reset_sent_at, Time.zone.now)
    end
        # Sends password reset email.
    def send_password_reset_email
        if Rails.env.production?
            UserMailer.mail_gun_password_reset(self).deliver_now
        else
            UserMailer.password_reset(self).deliver_now
        end
    end
    def activate
        # update_attribute(:activated, true)
        # update_attribute(:activated_at, Time.zone.now)
        update_columns(activated: true, activated_at: Time.zone.now)
    end
    # Sends activation email.
    def send_activation_email
        if Rails.env.production?
            UserMailer.mail_gun_account_activation(self).deliver_now
        else
            UserMailer.account_activation(self).deliver_now
        end
    end
    #Returns true if a password reset has expired.
    def password_reset_expired?
        reset_sent_at < 2.hours.ago
    end
    def feed
        # Micropost.where("user_id IN (?) OR user_id = ?", following_ids, id)
        # Micropost.where("user_id IN (:following_ids) OR user_id = :user_id", following_ids: following_ids, user_id: id)
        following_ids = "SELECT followed_id FROM relationships WHERE follower_id = :user_id"
        Micropost.where("user_id IN (#{following_ids}) OR user_id = :user_id", user_id: id)
    end

    def haiku_feed  
        Haiku.where("user_id = ?", id)
    end
    # Follows a user.
    def follow(other_user)
        following << other_user
    end
    # Unfollows a user.
    def unfollow(other_user)
        following.delete(other_user)
    end
    # Returns true if the current user is following the other user.
    def following?(other_user)
        following.include?(other_user)
    end
    # React to micropost.
    def reacted?(micropost_id)
        if(Micropost.find_by(id: micropost_id) && self.reactions.find_by(micropost_id: micropost_id))
            return true
        else
            return false
        end
    end

    def likedComment?(haiku_id)
        if Haiku.find_by(id: haiku_id) && self.haiku_reactions.find_by(haiku_id: haiku_id)
            return true
        else
            false
        end
    end

    # mekedem's code starts here in the model 
    def suggest_user_by_number_of_post

        userswithpostcount = {};
        alluserids = User.pluck(:id);

        alluserids.each do |userid|
            usersforfilter = User.find_by(id: userid);
            unless self.following?(usersforfilter) || self.id == usersforfilter.id
                postcount = usersforfilter.haikus.count;
                if (postcount > 0) 
                    userswithpostcount[userid] = postcount;
                end
            end
        end

        if(userswithpostcount.length > 10)
            toptenSuggestions = get_max_ten_values(userswithpostcount);
            return User.where(id: toptenSuggestions);
        else
            topsuggestions = userswithpostcount.keys;
            return User.where(id: topsuggestions);
        end
    end

    # end of mekedem's code 

    # unreact  a micropost.
    private
        def downcase_email
            self.email = email.downcase
        end
        # Creates and assigns the activation token and digest.
        def create_activation_digest
            self.activation_token = User.new_token
            self.activation_digest = User.digest(activation_token)
        end
end
