class CreateCalmatSolutions < ActiveRecord::Migration
  def self.up
    create_table :calmat_solutions do |t|
      t.string :value
      t.integer :test_id
      t.integer :user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :calmat_solutions
  end
end
