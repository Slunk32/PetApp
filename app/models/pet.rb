class Pet < ActiveRecord::Base
  has_many :personalities
  belongs_to :user
end
