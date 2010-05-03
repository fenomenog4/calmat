class CreateDnis < ActiveRecord::Migration
  def self.up
    create_table :dnis do |t|
      t.string :value

      t.timestamps
    end
  end

  def self.down
    drop_table :dnis
  end
end
