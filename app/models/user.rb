class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, :role, presence: true

  has_many :jobs, dependent: :destroy
  has_many :applications, dependent: :destroy
  has_many :messages, dependent: :destroy
end
