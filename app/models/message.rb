class Message < ApplicationRecord
  validates :name, :title, :body, presence: true
   
  belongs_to :user
end
