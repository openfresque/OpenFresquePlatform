require "administrate/field/base"

class ColorField < Administrate::Field::Base
  def to_s
    data
  end
end
