class Application < ApplicationRecord
  validates :applicant_information, :resume_text, :cover_letter, :application_status, presence: true

  belongs_to :user
  belongs_to :job
end
