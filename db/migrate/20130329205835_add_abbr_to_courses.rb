class AddAbbrToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :abbr, :string
  end
end
