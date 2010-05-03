class RenameAbstractTestIdColumnInTestImagesTableToTestId < ActiveRecord::Migration
  def self.up
    rename_column(:test_images, :abstract_test_id, :test_id)
  end

  def self.down
    rename_column(:test_images, :test_id, :abstract_test_id)
  end
end
