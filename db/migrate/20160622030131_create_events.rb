class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name
      t.datetime :startdate
      t.datetime :enddate
      t.string :url
      t.integer :type
      t.references :college, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
