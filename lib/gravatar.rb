module Gravatar
  def avatar_url(user) 
    gravatar_id = Digest::MD5::hexdigest(user.email).downcase
    "http://gravatar.com/avatar/#{gravatar_id}.png?s=40"
  end
end
