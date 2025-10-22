class User < ApplicationRecord
  has_secure_password validations: false
  has_many :sessions, dependent: :destroy
  has_many :expenses, dependent: :destroy
  has_many :categories, -> { distinct }, through: :expenses
  has_many :oauth_providers, dependent: :destroy

  normalizes :email_address, with: ->(e) { e.strip.downcase }

  attr_accessor :skip_password_validation

  validates :password, presence: true, on: :create, unless: :skip_password_validation

  def self.find_or_create_from_oauth(provider, uid, email, tokens = {})
    oauth_provider = OauthProvider.find_by(provider: provider, uid: uid)

    if oauth_provider
      user = oauth_provider.user
      # Update tokens if provided
      oauth_provider.update(
        access_token: tokens[:access_token],
        refresh_token: tokens[:refresh_token],
        expires_at: tokens[:expires_at]
      )
      return user
    end

    # If not found, try to find user by email
    user = User.find_by(email_address: email)

    # If user doesn't exist, create new user
    unless user
      user = User.new(email_address: email)
      user.skip_password_validation = true
      user.save!
    end

    # Create oauth provider record
    user.oauth_providers.create!(
      provider: provider,
      uid: uid,
      access_token: tokens[:access_token],
      refresh_token: tokens[:refresh_token],
      expires_at: tokens[:expires_at]
    )

    user
  end
end
