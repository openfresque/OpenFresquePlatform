class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class
  include OpenFresk::Extensions::StringEnum
end
