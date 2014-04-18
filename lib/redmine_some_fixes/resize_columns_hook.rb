module RedmineSomeFixes
  class ResizeColumnHook < Redmine::Hook::ViewListener
    render_on :view_layouts_base_html_head, :inline => "<%= javascript_include_tag 'colResizable-1.3.min.js', :plugin => 'redmine_some_fixes' %>"
    #render_on :view_layouts_base_html_head, :inline => "<%= javascript_include_tag 'flexigrid.pack.js', :plugin => 'redmine_some_fixes' %>"
    render_on :view_layouts_base_body_bottom, :text => %{<script>
  $(function(){
    $.each($("table.list:not(.memberships,.history)"), function(index, table_list){
       $.each($(table_list).find('tr:first').first().find('th,td'), function(index,th){
        var colWidth = $($(table_list).find('tr:last').first().find('td')[index]).css('width')
        $(th).css('width', colWidth);
        console.log($(th));
      });
      $(table_list).colResizable({postbackSafe: true});
    });
  });
</script>}
  end
end
