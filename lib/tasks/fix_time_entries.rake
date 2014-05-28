namespace :redmine_some_fixes do
  task :fix_time_entries => :environment do
    ActiveRecord::Migration.change_column :estimated_times, :hours, :float, :null => false
    ActiveRecord::Migration.change_column :time_entries, :hours, :float, :null => false
  end
end
