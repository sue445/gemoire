require File.expand_path("../boot.rb", __FILE__)

# Loads the Padrino applications mounted within the project.
Padrino.mounted_apps.each do |app|
  logger.info "=> Loading Padrino Application : #{app.app_class}"
  app.app_obj.setup_application!
end


SIDEKIQ_NAMESPACE = "gemoire"

Padrino.after_load do
  require "sidekiq"
  if ENV["REDISCLOUD_URL"]
    # heroku
    server_url = client_url = ENV["REDISCLOUD_URL"]
  else
    server_url = Global.sidekiq.server_url
    client_url = Global.sidekiq.client_url
  end
  Sidekiq.configure_server do |config|
    config.redis = {url: server_url, namespace: SIDEKIQ_NAMESPACE}
  end

  Sidekiq.configure_client do |config|
    config.redis = {url: client_url, namespace: SIDEKIQ_NAMESPACE}
  end

  Sidekiq.redis do |conn|
    conn.ping
  end
end
