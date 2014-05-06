module RedmineSomeFixes
  class TurbolinksHook < Redmine::Hook::ViewListener
    render_on :view_layouts_base_html_head, :inline => "<%= javascript_include_tag 'jquery.turbolinks', :plugin => 'redmine_some_fixes' %><%= javascript_include_tag 'turbolinks', :plugin => 'redmine_some_fixes' %>"
  end
end
