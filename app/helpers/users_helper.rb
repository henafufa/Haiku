module UsersHelper
    def gravatar_for(user, options = { size: 80, email:'' })

        size = options[:size]
        gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
        gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
        image_tag(gravatar_url, alt: user.name, class: "gravatar img-circle")
    end

    def get_max_four_values(userid_postnumber_hash)
        userid_postnumber_hash.sort_by { |_, v| -v }.first(4).map(&:first)
    end

    def shorten_name(username)
        if(username.length > 10)
            shortened = username[0..9] + ".."
            return shortened
        end

        return username
        
    end
end
