class CalmatSolution < ActiveRecord::Base
  TOL = 10**-2

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

  def equivalent?(user_solution)
    return false if self.raw_value.length != user_solution.raw_value.length

    self.raw_value.each_with_index do |e, i|
      unless (e - e/100..e + e/100).include?(user_solution.raw_value[i])
        return false
      end
    end

    max = 0
    self.raw_value.each_with_index do |e, i|
      s = e - user_solution.raw_value[i]
      unless e == 0
        s /= e
      end

      if s > max
        max = s
      end
    end

    return max < TOL
  end
end
