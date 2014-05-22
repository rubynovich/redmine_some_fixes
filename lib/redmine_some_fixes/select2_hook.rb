module RedmineSomeFixes
  class Select2Hook < Redmine::Hook::ViewListener
 #   begin
 #     size = (Setting[:plugin_redmine_some_fixes][:width_for_principals_options_for_select] || '60%').to_s
 #   rescue
      size = '60%'
 #   end
    #render_on :view_layouts_base_html_head, :inline => "<%= stylesheet_link_tag 'select2', :plugin => 'redmine_some_fixes'%><%= javascript_include_tag 'select2', :plugin => 'redmine_some_fixes' %><%= javascript_include_tag 'select2_locale_#{I18n.locale.to_s}', :plugin => 'redmine_some_fixes' %>"
    render_on :view_layouts_base_body_bottom, :text => %{<script>
  $(function(){

function isMobile() {
 try {
    if(/Android|webOS|iPhone|iPad|iPod|pocket|psp|kindle|avantgo|blazer|midori|Tablet|Palm|maemo|plucker|phone|BlackBerry|symbian|IEMobile|mobile|ZuneWP7|Windows Phone|Opera Mini/i.test(navigator.userAgent)) {
     return true;
    };
    return false;
 } catch(e){ console.log("Error in isMobile"); return false; }
}

    if(! isMobile()){
      var update_js = function(){
        $(".select2").select2();
        var user_select = $("select[id$=user_id], select[id$=author_id], p.user_id select, select[id$=assigned_to_id], select[id$=user_id]");
        user_select.attr('style','width:#{size}; min-width: 300px;');
        user_select.select2();
      }
      $(document).on('click', 'a', function(){
        update_js();
      });
      $(document).ready(function() {
        update_js();
      });
      $(document).on('page:load page:change page:restore', function () {
        update_js();
      });
    };
  });
</script>}
  end
end
