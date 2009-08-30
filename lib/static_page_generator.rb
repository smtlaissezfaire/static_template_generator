class StaticPageGenerator
  class << self
    def generate
      new.generate
    end
    
    attr_writer :settings
    
    def settings
      @settings ||= {
        :app_host => "localhost:3000"
      }
    end
  end

  def generate
    templates.each do |template_name|
      auth = if settings.key?(:http_basic_auth) && settings[:http_basic_auth].key?(:user) && settings[:http_basic_auth].key?(:password)
        " -u #{settings[:http_basic_auth][:user]}:#{settings[:http_basic_auth][:password]} "
      else
        ""
      end
      sh "curl #{auth} http://#{settings[:app_host]}/static/#{template_name} > #{RAILS_ROOT}/public/#{template_name}.html"
    end
  end

  def templates
    @templates ||= Dir.glob("#{RAILS_ROOT}/app/views/static/*").map do |file|
      File.basename(file).gsub(".html.erb", "")
    end
  end
  
private

  def settings
    self.class.settings
  end
end
