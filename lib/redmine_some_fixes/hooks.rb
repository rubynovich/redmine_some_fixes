module RedmineSomeFixes
  class Hooks < Redmine::Hook::ViewListener
    #render_on :view_layouts_base_html_head, :inline => "<%= stylesheet_link_tag :some_fixes, :plugin => 'redmine_some_fixes' %>"
  end
end
