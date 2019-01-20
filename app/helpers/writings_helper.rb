module WritingsHelper

  def topic_name_for(code_name)
    if code_name == 'short-story'
      'Short Story'
    elsif code_name == 'student-life'
      'Student Life'
    elsif code_name == 'technology'
      'Technology & Innovation'
    else
      code_name.capitalize
    end
  end

  def topic_color_for(code_name)
    if code_name == 'short-story' || code_name == 'poetry' || code_name == 'fantasy'
      'orange'
    else
      'teal'
    end
  end

  def extract_image_from(body)
    if Nokogiri::HTML(body).css('img').map { |i| i['src'] }[0]
      Nokogiri::HTML(body).css('img').map { |i| i['src'] }[0]
    end
  end

  def extract_text_from(body, length)
    truncate(Nokogiri::HTML(body).css('p').text, length: length, separator: ' ')
  end

  def image?(body)
    if Nokogiri::HTML(body).css('img').map { |i| i['src'] }[0]
      true
    else
      false
    end
  end

  def description_id(body)
    if image?(body)
      'sl-with-image'
    else
      'sl-no-image'
    end
  end

end
