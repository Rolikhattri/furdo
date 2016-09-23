class User < ActiveRecord::Base
	has_many :installments, :foreign_key => :user_id, dependent: :destroy
	validates_presence_of :name, :email, :total_amount
	validates_format_of :email, with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
	
end
