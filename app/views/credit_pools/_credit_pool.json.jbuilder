# frozen_string_literal: true

json.extract! credit_pool, :id, :credits, :created_at, :updated_at
json.url credit_pool_url(credit_pool, format: :json)
