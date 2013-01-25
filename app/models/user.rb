class User < ActiveRecord::Base
  authenticates_with_sorcery!
  has_many :authentications, dependent: :destroy

  def admin?
    username == "wazuma_circle"
  end
  def authentication(provider)
    authentications.where(provider: provider).first
  end

  def self.list_owner
    @twitter ||=
      Twitter::Client.new(
        consumer_key: ENV["TWITTER_LIST_DEV_KEY"],
        consumer_secret: ENV["TWITTER_LIST_DEV_SECRET"],
        oauth_token: ENV["TWITTER_LIST_OWNER_TOKEN"],
        oauth_token_secret: ENV["TWITTER_LIST_OWNER_SECRET"]
      )
  end

  def join_to_list
    User::list_owner.list_add_member(84216600, self.username)
  rescue e

  end
  def remove_from_list
    User::list_owner.list_remove_member(84216600, self.username) rescue nil
  end
end
