class AddFieldActiveInTask < ActiveRecord::Migration
  def change
  	add_column :tasks, :active, :boolean, default: false
  end
end
