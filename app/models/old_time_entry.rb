begin
  class OldTimeEntry < ActiveRecord::Base
    unloadable
    establish_connection "old_#{Rails.env.to_s}"
    set_table_name "time_entries"
  end
rescue
end