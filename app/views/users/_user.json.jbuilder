json.extract! user, :id, :name, :email, :total_amount, :discount, :percentage, :emi_option, :created_at, :updated_at
json.url user_url(user, format: :json)