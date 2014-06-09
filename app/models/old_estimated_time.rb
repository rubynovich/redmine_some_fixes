begin
  class OldEstimatedTime < ActiveRecord::Base
    unloadable
    establish_connection "old_#{Rails.env.to_s}"
    self.table_name = "estimated_times"
  end
rescue
end