  u require_dependency 'fileutils'
FileUtils.mkdir_p("#{Rails.root}/private") unless Dir.exist?("#{Rails.root}/private")
#FileUtils.ln_sf("#{Rails.root}/)
Rails.configuration.before_configuration do
  require_dependency 'redmine_plugin_asset_pipeline/plugin_patch'
  #unless Redmine::Plugin.included_modules.include? RedminePluginAssetPipeline::PluginPatch
  Redmine::Plugin.send(:include, RedminePluginAssetPipeline::PluginPatch)
  #end
end
locale = :ru

I18n.default_locale = locale.to_s
I18n.backend = Redmine::I18n::Backend.new

require 'redmine'

# Load the secret token from the Redmine configuration file
secret = Redmine::Configuration['secret_token']
if secret.present?
  RedmineApp::Application.config.secret_token = secret
end

if Object.const_defined?(:OpenIdAuthentication)
  openid_authentication_store = Redmine::Configuration['openid_authentication_store']
  OpenIdAuthentication.store =
    openid_authentication_store.present? ?
      openid_authentication_store : :memory   
end

Redmine::Plugin.load

#unless Redmine::Configuration['mirror_plugins_assets_on_startup'] == false
  require_dependency 'redmine_plugin_asset_pipeline/plugin_patch'
  #unless Redmine::Plugin.included_modules.include? RedminePluginAssetPipeline::PluginPatch
  Redmine::Plugin.send(:include, RedminePluginAssetPipeline::PluginPatch)
  #end
  Redmine::Plugin.mirror_assets

  #hard code fix to prepare application.js

  js_code = %{//= require ./app
#{"//= require ./jstoolbar/lang/jstoolbar-#{locale}.js" if File.exists?("#{Rails.root}/vendor/assets/javascripts/jstoolbar/lang/jstoolbar-#{locale}.js")}
#{"//= require ./i18n/jquery.ui.datepicker-#{locale}.js" if File.exists?("#{Rails.root}/vendor/assets/javascripts/i18n/jquery.ui.datepicker-#{locale}.js")}
#{(Dir["#{Rails.root}/private/**/application.js.*"] +  Dir["#{Rails.root}/private/**/application.js"]).sort.map do |script|
  "//= require #{script.gsub("#{Rails.root.to_s}/private/plugin_assets/",'')}"
end.join("\n")
}
}
  application_js = File.open("#{Rails.root}/vendor/assets/javascripts/application.js", "w+")
  application_js.write(js_code)
  application_js.close
  #hard code fix to prepare application.css
  css_code = %{/*
#{(Dir["#{Rails.root}/private/**/application.css.*"] +  Dir["#{Rails.root}/private/**/application.css"]).sort.map do |css|
    " *= require #{css.gsub("#{Rails.root.to_s}/private/plugin_assets/",'')}"
  end.join("\n")
  }
*/
}
  application_css = File.open("#{Rails.root}/vendor/assets/stylesheets/application.css", "w+")
  application_css.write(css_code)
  application_css.close
#end
