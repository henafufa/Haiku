module UsersHelper
    def gravatar_for(user, options = { size: 80, email:'' })
        p "1 #{user} %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%"
        p "2222222222222222222222 #{options[:email]}"

        size = options[:size]
        gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
        gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
        image_tag(gravatar_url, alt: user.name, class: "gravatar img-circle")
    end
end
