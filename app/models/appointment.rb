class Appointment < ActiveRecord::Base
  belongs_to :pet
  belongs_to :user
  validates :pet, presence: true
  validates :user, presence: true
end
