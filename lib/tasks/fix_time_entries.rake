namespace :redmine_some_fixes do
  task :fix_time_entries => :environment do
    ActiveRecord::Migration.change_column :estimated_times, :hours, :float, :null => false
    ActiveRecord::Migration.change_column :time_entries, :hours, :float, :null => false
  end

  task :back_float_times => :environment do
    puts OldEstimatedTime.all.count
    OldEstimatedTime.where("hours <> round(hours)").map{|i| {id: i.id, hours: i.hours}}.each do |t|
      EstimatedTime.find(t[:id]).update_column(:hours, t[:houts]) unless t[:houts].nil?
    end
    puts OldTimeEntry.all.count
    OldTimeEntry.where("hours <> round(hours)").map{|i| {id: i.id, hours: i.hours}}.each do |t|
      TimeEntry.find(t[:id]).update_column(:hours, t[:houts]) unless t[:houts].nil?
    end
  end
end
