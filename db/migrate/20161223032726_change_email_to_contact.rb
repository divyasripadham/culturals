class ChangeEmailToContact < ActiveRecord::Migration
  def change
    rename_column :events, :email, :contact
  end
end
