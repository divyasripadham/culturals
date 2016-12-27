class AddCollegeUrlToEvents < ActiveRecord::Migration
  def change
    add_column :events, :college_url, :string
  end
end
