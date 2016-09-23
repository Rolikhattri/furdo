json.extract! installment, :id, :due_date, :payment_date, :status, :amount, :user_id, :created_at, :updated_at
json.url installment_url(installment, format: :json)