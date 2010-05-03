class UserSolution < ActiveRecord::Base
  belongs_to :user
  belongs_to :test

  validates_presence_of :value
  serialize :value

  def value=(value)
    unless value.is_a?(Array)
      value = value.split(/\s*,\s*/)
    end
    value.map!(&:to_f)

    write_attribute(:value, value)
  end

  def value
    data = read_attribute(:value)

    data.join(', ') if data
  end

  def raw_value
    read_attribute(:value)
  end
end
