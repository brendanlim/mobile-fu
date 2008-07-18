module MobilizedStyles
  
  # This logic was taken from Michael Bleigh's browserized styles
  # with modification to work for mobile browsers.
  
  def user_agent_device_name
    @user_agent_device_name ||= begin

      ua = request.user_agent
      return nil if ua.nil?
      ua.downcase!

      if ua.index('mobileexplorer') || ua.index('windows ce')
        'mobileexplorer'
      elsif ua.index('blackberry') 
        'blackberry'
      elsif ua.index('iphone') 
        'iphone'
      elsif ua.index('nokia') 
        'nokia'
      elsif ua.index('palm') 
        'palm'
      end
    end
  end

  def stylesheet_link_tag_with_mobilization(*sources)
    mobilized_sources = Array.new
    sources.each do |source|
      subbed_source = source.to_s.gsub(".css","")

      possible_sources = ["#{subbed_source.to_s}_#{user_agent_device_name}"]

      mobilized_sources << source

      for possible_source in possible_sources
        path = File.join(ActionView::Helpers::AssetTagHelper::STYLESHEETS_DIR,"#{possible_source}.css")
        sass_path = File.join(ActionView::Helpers::AssetTagHelper::STYLESHEETS_DIR,"sass","#{possible_source}.sass")
        mobilized_sources << possible_source if File.exist?(path) || File.exist?(sass_path)
      end
    end

    stylesheet_link_tag_without_mobilization(*mobilized_sources)
  end
end