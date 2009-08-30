require File.expand_path(File.dirname(__FILE__) + "/../lib/static_page_generator")

namespace :static_templates do
  desc "Generate static templates"
  task :generate do
    StaticPageGenerator.generate
  end
end
