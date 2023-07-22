class Application < ApplicationRecord
  validates :applicant_information, :resume_text, :cover_letter, :application_status, presence: true

  has_rich_text :applicant_information
  has_rich_text :resume_text
  has_rich_text :cover_letter

  belongs_to :user
  belongs_to :job
end
