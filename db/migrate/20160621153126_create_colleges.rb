class CreateColleges < ActiveRecord::Migration
  def change
    create_table :colleges do |t|
      t.string :name
      t.string :address1
      t.string :city
      t.string :state

      t.timestamps null: false
    end
  end
end
