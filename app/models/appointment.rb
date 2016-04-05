class Appointment < ActiveRecord::Base
  # appointments require a pet and a user. Pets can only have one unique date associated with them.
  belongs_to :pet
  belongs_to :user
  validates :pet, presence: true
  validates :user, presence: true
  validates :date, presence: true
  validates_uniqueness_of :date, scope: :pet_id, :message => "already exists"
end
