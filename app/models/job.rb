class Job < ApplicationRecord
  validates :title, :description, presence: true

  has_many :applications
  belongs_to :user
end
