module ApplicationHelper

  # Returns a users gravatar_url
  def gravatar_url(user, size)
    id = user.gravatar_id || ''
    "https://secure.gravatar.com/avatar/#{id}.png?s=#{size}&d=https://a248.e.akamai.net/assets.github.com%2Fimages%2Fgravatars%2Fgravatar-user-420.png"
  end 
end
