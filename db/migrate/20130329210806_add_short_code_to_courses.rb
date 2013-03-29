class AddShortCodeToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :short_code, :string
  end
end
