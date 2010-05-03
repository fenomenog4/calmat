class CreateTests < ActiveRecord::Migration
  def self.up
    create_table :tests do |t|
      t.string :title, :latex_filename, :data_filename
      t.text :description

      t.timestamps
    end
  end

  def self.down
    drop_table :tests
  end
end
