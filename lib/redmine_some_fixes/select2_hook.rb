module RedmineSomeFixes
  class Select2Hook < Redmine::Hook::ViewListener
 #   begin
 #     size = (Setting[:plugin_redmine_some_fixes][:width_for_principals_options_for_select] || '60%').to_s
 #   rescue
      size = '60%'
 #   end
    render_on :view_layouts_base_html_head, :inline => "<%= stylesheet_link_tag 'select2', :plugin => 'redmine_some_fixes'%><%= javascript_include_tag 'select2', :plugin => 'redmine_some_fixes' %><%= javascript_include_tag 'select2_locale_#{I18n.locale.to_s}', :plugin => 'redmine_some_fixes' %>"
    render_on :view_layouts_base_body_bottom, :text => %{<script>
  $(function(){
    var update_js = function(){
      $("p.user_id select, #issue_assigned_to_id, #incoming_letter_recipient_user_id, #outgoing_letter_signer_user_id").attr('style','width:#{size};');
      $(".select2, #issue_assigned_to_id, p.user_id select, #incoming_letter_recipient_user_id, #outgoing_letter_signer_user_id").select2();
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
  });
</script>}
  end
end
