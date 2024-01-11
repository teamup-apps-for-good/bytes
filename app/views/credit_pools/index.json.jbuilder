# frozen_string_literal: true

json.array! @credit_pools, partial: 'credit_pools/credit_pool', as: :credit_pool
