class Appointment < ActiveRecord::Base
  belongs_to :pet
  belongs_to :user
  validates :pet, presence: true
  validates :user, presence: true
  validates :date, presence: true
  validates_uniqueness_of :date, scope: :pet_id, :message => "already exists"
end
