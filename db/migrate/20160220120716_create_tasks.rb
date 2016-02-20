class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.integer :list_id
      t.string :title
      t.text :description
      t.datetime :start_time
      t.datetime :end_time
      t.datetime :pause_time
      t.datetime :elapsed_time

      t.timestamps null: false
    end
  end
end
