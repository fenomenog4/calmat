class CreateTestImages < ActiveRecord::Migration
  def self.up
    create_table :test_images do |t|
      t.belongs_to :abstract_test
      t.string :filename
      t.timestamps
    end

    add_index :test_images, :abstract_test_id
  end

  def self.down
    drop_table :test_images
  end
end
