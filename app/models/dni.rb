class Dni < ActiveRecord::Base
  validates_presence_of :value
 validates_uniqueness_of :value

  @@per_page = 10
  cattr_reader :per_page
end
