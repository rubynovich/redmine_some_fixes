require 'redmine'

Redmine::Plugin.register :redmine_some_fixes do
  name 'Redmine Some Fixes plugin'
  author 'Roman Shipiev'
  description 'Redmine plugin for fixing too long project title'
  version '0.0.1'
  url 'https://github.com/rubynovich/redmine_some_fixes'
  author_url 'http://roman.shipiev.me'
  
  settings :default => {
    :wrap_length => 40,
    :tranc_length => 40
  }  
end

require_dependency 'application_helper'

ActionView::Base.class_eval do
  include ApplicationHelper
  
  def link_to_project_with_tranc(project, options={}, html_options = nil)
    project_name = word_wrap(
      h(project), 
      Setting[:plugin_redmine_some_fixes][:wrap_length]
    ).gsub(/\n/){ "<br />" }
    if project.active?
      url = {:controller => 'projects', :action => 'show', :id => project}.merge(options)
      link_to(project_name, url, html_options)
    else
      h(project_name)
    end
  end     
  
  alias_method_chain :link_to_project, :tranc
end
