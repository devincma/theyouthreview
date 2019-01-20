module UsersHelper

  def avatar_for(user, thumb_option, additional_class)
    if user.avatar?
      image_tag user.avatar.url(thumb_option), class: "ui image #{additional_class}", alt: full_name_for(user)
    else
      image_tag 'https://d1cndlyhl5fqed.cloudfront.net/assets/default_avatar.png', class: "ui image #{additional_class}", alt: full_name_for(user)
    end
  end

  def full_name_for(user)
    user.first_name + ' ' + user.last_name
  end

  def profile_completed?(user)
    if user.school == '' || user.country == '' || user.link == '' || user.about_me == ''
      false
    else
      true
    end
  end

  def user_link_for(user)
    if user.link.include? 'https://'
      user.link
    elsif user.link.include? 'http://'
      user.link
    else
      'http://' + user.link
    end
  end

end