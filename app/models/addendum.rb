class Addendum < ActiveRecord::Base
  belongs_to :portrayed, polymorphic: true
end
