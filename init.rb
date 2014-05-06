require 'redmine'
require 'redmine_some_fixes/hooks'
require 'redmine_some_fixes/select2_hook'
require 'redmine_some_fixes/turbolinks_hook'

Redmine::Plugin.register :redmine_some_fixes do
  name 'Some fixes'
  author 'Roman Shipiev'
  description 'Trancating project name to 30 chars in all project selects, links to projects, in headers'
  version '0.0.4'
  url 'https://bitbucket.org/rubynovich/redmine_some_fixes'
  author_url 'http://roman.shipiev.me'

  settings :default => {
    :wrap_length => 60,
    :tranc_length => 60
  }, :partial => 'settings/some_fixes_settings'

end

require_dependency 'application_helper'

ActionView::Base.class_eval do
  include ApplicationHelper

  def link_to_project_with_tranc(project, options={}, html_options = nil)
    project_name = word_wrap(
      h(project),
      :line_width => Setting[:plugin_redmine_some_fixes][:wrap_length].to_i
    ).gsub(/\n/){ "<br />" }.html_safe
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
      name_prefix = (level > 0 ? '&nbsp;' * 2 * level + '&#187; ' : '').html_safe
      tag_options = {:value => project.id}
      if project == options[:selected] || (options[:selected].respond_to?(:include?) && options[:selected].include?(project))
        tag_options[:selected] = 'selected'
      else
        tag_options[:selected] = nil
      end
      tag_options.merge!(yield(project)) if block_given?
      s << content_tag('option',
        truncate(name_prefix + h(project),
          :length => Setting[:plugin_redmine_some_fixes][:tranc_length].to_i,
          :separator => ' ').html_safe,
        tag_options)
    end
    s.html_safe
  end

  def time_tag_with_add_info(time)
    text = "#{format_time(time)}, #{distance_of_time_in_words(Time.now, time)}".html_safe
    if @project
      link_to(text, {:controller => 'activities', :action => 'index', :id => @project, :from => time.to_date}, :title => format_time(time))
    else
      content_tag('acronym', text, :title => format_time(time))
    end
#    if @project
#      link_to(text, {:controller => 'activities', :action => 'index', :id => @project, :from => User.current.time_to_date(time)}, :title => format_time(time))
#    else
#      content_tag('acronym', text, :title => format_time(time))
#    end
  end

  def principals_options_for_select_with_select2_fix(collection, selected=nil)
    ret = principals_options_for_select_without_select2_fix(collection, selected)
    ret.gsub!('<option', '<option class="option_select2" style="width:'+(Setting[:plugin_redmine_some_fixes][:width_for_principals_options_for_select] || '60%').to_s+'"')
    ret.html_safe
  end

  alias_method_chain :principals_options_for_select, :select2_fix

  alias_method_chain :link_to_project, :tranc
  alias_method_chain :project_tree_options_for_select, :tranc
  alias_method_chain :time_tag, :add_info
end
