class User < ActiveRecord::Base
	has_many :installments, :foreign_key => :user_id
	validates_presence_of :name
	validates_presence_of :email
	validates_presence_of :total_amount

	
end
