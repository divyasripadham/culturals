class AddAddressToEvents < ActiveRecord::Migration
  def change
    add_column :events, :address_temp, :string
  end
end
