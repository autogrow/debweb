class Branch < ActiveRecord::Base
  has_many :packages
end
