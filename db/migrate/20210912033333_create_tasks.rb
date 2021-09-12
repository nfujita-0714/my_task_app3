class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.string :title
      t.string :contents
      t.bigint :user_id
      t.date :task_limit_on
      t.integer :task_status

      t.timestamps
    end
  end
end
