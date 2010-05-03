class TestImage < ActiveRecord::Base

  belongs_to :test

  def image_file=(image_file)
    self.filename = image_file.original_filename
    @image_file_data = image_file.read
  end

  def image_file_data
    @image_file_data
  end
end
