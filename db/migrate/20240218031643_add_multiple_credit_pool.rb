class AddMultipleCreditPool < ActiveRecord::Migration[7.1]
  def change
    add_column :credit_pools, :school_name, :string
    add_column :credit_pools, :email_suffix, :string
    add_column :credit_pools, :logo_url, :string
    add_column :credit_pools, :id_name, :string
  end
end
