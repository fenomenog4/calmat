class CreateUserSolutions < ActiveRecord::Migration
  def self.up
    create_table :user_solutions do |t|
      t.string :value
      t.integer :user_id, :test_id
      t.boolean :right
      t.timestamps
    end
  end

  def self.down
    drop_table :user_solutions
  end
end
