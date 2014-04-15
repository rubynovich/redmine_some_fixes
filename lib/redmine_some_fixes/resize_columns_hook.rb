module RedmineSomeFixes
  class ResizeColumnHook < Redmine::Hook::ViewListener
    render_on :view_layouts_base_html_head, :inline => "<%= javascript_include_tag 'colResizable-1.3.min.js', :plugin => 'redmine_some_fixes' %>"
    #render_on :view_layouts_base_html_head, :inline => "<%= javascript_include_tag 'flexigrid.pack.js', :plugin => 'redmine_some_fixes' %>"
    render_on :view_layouts_base_body_bottom, :text => %{<script>
  $(function(){
    $("table").colResizable();
    //$("table").flexigrid();
  });
</script>}
  end
end
