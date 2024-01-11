# frozen_string_literal: true

# Migration that adds OAuth details to users
class AddOauthDetailsToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :uid, :string
    add_column :users, :provider, :string
  end
end
