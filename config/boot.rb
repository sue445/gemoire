# Defines our constants
RACK_ENV = ENV['RACK_ENV'] ||= 'development'  unless defined?(RACK_ENV)
PADRINO_ROOT = File.expand_path('../..', __FILE__) unless defined?(PADRINO_ROOT)

# Load our dependencies
require 'rubygems' unless defined?(Gem)
require 'bundler/setup'
Bundler.require(:default, RACK_ENV)

##
# ## Enable devel logging
#
# Padrino::Logger::Config[:development][:log_level]  = :devel
# Padrino::Logger::Config[:development][:log_static] = true
#
# ## Configure your I18n
#
# I18n.default_locale = :en
# I18n.enforce_available_locales = false
#
# ## Configure your HTML5 data helpers
#
# Padrino::Helpers::TagHelpers::DATA_ATTRIBUTES.push(:dialog)
# text_field :foo, :dialog => true
# Generates: <input type="text" data-dialog="true" name="foo" />
#
# ## Add helpers to mailer
#
# Mail::Message.class_eval do
#   include Padrino::Helpers::NumberHelpers
#   include Padrino::Helpers::TranslationHelpers
# end

##
# Add your before (RE)load hooks here
#
Padrino.before_load do
end

##
# Add your after (RE)load hooks here
#
Padrino.after_load do
  Global.configure do |config|
    unless File.exist?(Padrino.root("config/global/gemoire.yml"))
      # for Heroku
      FileUtils.cp(Padrino.root("config/global/gemoire.yml.example"), Padrino.root("config/global/gemoire.yml"))
    end

    config.environment      = Padrino.env.to_s
    config.config_directory = Padrino.root("config/global")
  end

  FileUtils.mkdir_p(Global.gemoire.satellite_root_dir)
  FileUtils.mkdir_p(Global.gemoire.doc_root_dir)
  Time.zone = Global.gemoire.time_zone
end

Padrino.load!
