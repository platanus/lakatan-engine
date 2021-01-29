class Lakatan::InstallGenerator < Rails::Generators::Base
  source_root File.expand_path('templates', __dir__)

  def create_initializer
    template "initializer.rb", "config/initializers/lakatan.rb"
  end

  def mount_routes
    line = "Rails.application.routes.draw do\n"
    inject_into_file "config/routes.rb", after: line do <<-"HERE".gsub(/^ {4}/, '')
      mount Lakatan::Engine => "/lakatan"
    HERE
    end
  end

  def copy_engine_migrations
    rake "railties:install:migrations"
  end
end
