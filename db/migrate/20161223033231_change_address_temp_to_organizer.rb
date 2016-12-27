class ChangeAddressTempToOrganizer < ActiveRecord::Migration
  def change
    rename_column :events, :address_temp, :organizer
  end
end
