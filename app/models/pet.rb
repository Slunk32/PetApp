class Pet < ActiveRecord::Base
  has_many :personalities
  belongs_to :user
  has_attached_file :image, styles: { small: "80x80", med: "100x100", large: "200x200" }
  validates_attachment :image, presence: true,
    content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] },
    size: { in: 0..10.megabytes }
end
