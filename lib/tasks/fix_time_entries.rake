namespace :redmine_some_fixes do
  task :fix_time_entries => :environment do
    ActiveRecord::Migration.change_column :estimated_times, :hours, :float, :null => false
    ActiveRecord::Migration.change_column :time_entries, :hours, :float, :null => false
  end

  task :back_float_times => :environment do
    OldEstimatedTime.all.each do |oet|
      if et = EstimatedTime.where(id: oet.id).first
        et.update_column(:hours, oet.hours)
      end
    end
    OldTimeEntry.all.each do |ote|
      if te = TimeEntry.where(id: ote.id).first
        te.update_column(:hours, ote.hours)
      end
    end
  end
end
