begin
  class OldTimeEntry < ActiveRecord::Base
    unloadable
    establish_connection "old_#{Rails.env.to_s}"
    self.table_name = "time_entries"
  end
rescue
end