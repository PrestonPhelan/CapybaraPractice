class Goals < ActiveRecord::Migration
  def change
    create_table :goals do |t|
      t.string :goal_name, null: false
      t.integer :user_id, null: false
      t.boolean :priv, default: false
      t.boolean :complete, default: false
    end
  end
end
