module RedmineSomeFixes
  class ResizeColumnHook < Redmine::Hook::ViewListener
    render_on :view_layouts_base_html_head, :inline => "<%= javascript_include_tag 'colResizable-1.3.min.js', :plugin => 'redmine_some_fixes' %>"
    #render_on :view_layouts_base_html_head, :inline => "<%= javascript_include_tag 'flexigrid.pack.js', :plugin => 'redmine_some_fixes' %>"
    render_on :view_layouts_base_body_bottom, :text => %{<script>
  $(function(){
    //setup default width
    console.log($("table.list:not(.memberships)"));
    $.each($("table.list:not(.memberships)"), function(index, table_list){
      console.log(table_list);
      //var i = 0;
       $.each($(table_list).find('tr:first').first().find('th,td'), function(index,th){
        var colWidth = $($(table_list).find('tr:last').first().find('td')[index]).css('width')
        // $(th).css('background-color', '#00FF00');
        $(th).css('width', colWidth);
        console.log($(th));
        //i++;
      });
      //table_list
      $(table_list).colResizable({postbackSafe: true});
    });

  });
</script>}
  end
end
