class User < ApplicationRecord
	has_secure_password
	validates :username, :email, :password_digest, presence: true
	validates :username, :email, uniqueness: true
end
