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

  def project_tree_options_for_select_with_tranc(projects, options = {})
    s = ''
    project_tree(projects) do |project, level|
      name_prefix = (level > 0 ? ('&nbsp;' * 2 * level + '&#187; ').html_safe : '')
      tag_options = {:value => project.id}
      if project == options[:selected] || (options[:selected].respond_to?(:include?) && options[:selected].include?(project))
        tag_options[:selected] = 'selected'
      else
        tag_options[:selected] = nil
      end
      tag_options.merge!(yield(project)) if block_given?
      s << content_tag('option', 
        trancate(name_prefix + h(project), 
          :length => Setting[:plugin_redmine_some_fixes][:tranc_length], 
          :separator => ' '),
        tag_options)
    end
    s.html_safe
  end
  
  alias_method_chain :link_to_project, :tranc
  alias_method_chain :project_tree_options_for_select, :tranc
  
  private
    def trancate(text, options = {})      
      options[:omission] ||= "…"
      options[:length] ||= 30
      
      length_with_room_for_omission = options[:length] - options[:omission].mb_chars.length
      chars = text.mb_chars
      stop = options[:separator] ?
        (chars.rindex(options[:separator].mb_chars, length_with_room_for_omission) || length_with_room_for_omission) : length_with_room_for_omission

      (chars.length > options[:length] ? chars[0...stop] + options[:omission] : text).to_s
    end
end
