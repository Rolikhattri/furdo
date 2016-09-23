class User < ActiveRecord::Base
	has_many :installments, :foreign_key => :user_id
	validates_presence_of :name

	
end
