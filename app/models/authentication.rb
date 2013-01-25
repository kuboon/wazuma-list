class Authentication < ActiveRecord::Base
  belongs_to :user
  serialize :access_token_hash, Hash
  serialize :user_info_hash, Hash

  def share(message)
    case self.provider
    when "twitter"
      @twitter ||= Twitter::Client.new(
        :oauth_token => self.access_token_hash[:oauth_token],
        :oauth_token_secret => self.access_token_hash[:oauth_token_secret]
      )
      @twitter.update(message)
    when "facebook"
      @facebook ||= Koala::Facebook::API.new(self.access_token_hash[:token])
      @facebook.put_wall_post(message)
    end
  end
  def access_token=(token)
    self.access_token_hash =
      case token
      when OAuth::AccessToken
        {
          version: 1,
          oauth_token: token.token,
          oauth_token_secret: token.secret
        }
      when OAuth2::AccessToken
        {
          version: 2,
          token: token.token,
          expires_at: token.expires_at,
          expires_in: token.expires_in,
          refresh_token: token.refresh_token
        }
      end
  end
end
