class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :omniauthable, omniauth_providers: [:facebook]
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :odds
  has_many :bets

  def self.find_for_facebook_oauth(auth)
    user_params = auth.slice(:provider, :uid)
    user_params.merge! auth.info.slice(:email, :first_name, :last_name)
    user_params[:facebook_picture_url] = auth.info.image
    user_params[:token] = auth.credentials.token
    user_params[:token_expiry] = Time.at(auth.credentials.expires_at)
    user_params = user_params.to_h

    user = User.find_by(provider: auth.provider, uid: auth.uid)
    user ||= User.find_by(email: auth.info.email) # User did a regular sign up in the past.
    if user
      user.update(user_params)
    else
      user = User.new(user_params)
      user.password = Devise.friendly_token[0,20]  # Fake password for validation
      user.save
    end
    return user
  end

  def completed_bets
    bets.joins(:match).where('matches.status = ?', 'FINISHED').order(:created_at)
  end

  # TOMMY'S METHODS ###########
  def wins
    winning_bets = []
    self.bets.each do |bet|
      if bet.won? == "win"
        winning_bets << bet
      end
    end
  end

  def losses
    losing_bets = []
    self.bets.each do |bet|
      if bet.nil?
      else
        if bet.won? == "lose"
          losing_bets << bet
        end
      end
    end
  end

end
