class User < ActiveRecord::Base
  attr_accessible :name, :provider, :uid
  has_many :memberships
  has_many :groups, :through => :memberships
  
  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.name = auth["info"]["name"]
      if auth["provider"] == 'facebook'
        user.email = auth["info"]["email"]
        user.image = auth["info"]["image"].sub("square", "normal")
      else
        user.image = auth["info"]["image"].sub("_normal", "")
      end
    end
  end
end
