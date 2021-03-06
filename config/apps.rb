##
# This file mounts each app in the Padrino project to a specified sub-uri.
# You can mount additional applications using any of these commands below:
#
#   Padrino.mount('blog').to('/blog')
#   Padrino.mount('blog', :app_class => 'BlogApp').to('/blog')
#   Padrino.mount('blog', :app_file =>  'path/to/blog/app.rb').to('/blog')
#
# You can also map apps to a specified host:
#
#   Padrino.mount('Admin').host('admin.example.org')
#   Padrino.mount('WebSite').host(/.*\.?example.org/)
#   Padrino.mount('Foo').to('/foo').host('bar.example.org')
#
# Note 1: Mounted apps (by default) should be placed into the project root at '/app_name'.
# Note 2: If you use the host matching remember to respect the order of the rules.
#
# By default, this file mounts the primary app which was generated with this project.
# However, the mounted app can be modified as needed:
#
#   Padrino.mount('AppName', :app_file => 'path/to/file', :app_class => 'BlogApp').to('/')
#

def copy_global_for_heroku(name)
  unless File.exist?(Padrino.root("config/global/#{name}.yml"))
    # for Heroku
    FileUtils.cp(Padrino.root("config/global/#{name}.yml.heroku"), Padrino.root("config/global/#{name}.yml"))
  end
end

##
# Setup global project settings for your apps. These settings are inherited by every subapp. You can
# override these settings in the subapps as needed.
#
Padrino.configure_apps do
  # enable :sessions
  set :session_secret, 'bea2ab40d69fc76d1178f571380ecc78668d281c642eda79c0f8476265fa3d6b'
  set :protection, except: :path_traversal
  set :protect_from_csrf, true

  copy_global_for_heroku("gemoire")
  copy_global_for_heroku("redis")

  Global.configure do |config|
    config.environment      = Padrino.env.to_s
    config.config_directory = Padrino.root("config/global")
  end

  FileUtils.mkdir_p(Global.gemoire.satellite_root_dir)
  FileUtils.mkdir_p(Global.gemoire.doc_root_dir)
  Time.zone = Global.gemoire.time_zone
end

# Mounts the core application for this project

Padrino.mount("Gemoire::Admin", app_file: Padrino.root('admin/app.rb')).to("/admin")
Padrino.mount('Gemoire::App', app_file: Padrino.root('app/app.rb')).to('/')

# require 'sidekiq/web'
# Padrino.mount('Sidekiq::Web', app_class: 'Sidekiq::Web', app_root: Sidekiq::Web.root).to('/admin/sidekiq')
