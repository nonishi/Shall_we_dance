class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.integer :user_id
      t.integer :min_age
      t.integer :max_age
      t.integer :min_height
      t.integer :max_height
      t.integer :status, null: false, default: 0
      t.integer :directionality, null: false, default: 0
      t.integer :experience, null: false, default: 0
      t.string :place
      t.string :frequency
      t.text :comment

      t.timestamps
    end
  end
end
