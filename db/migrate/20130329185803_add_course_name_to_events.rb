class AddCourseNameToEvents < ActiveRecord::Migration
  def change
    add_column :events, :course_name, :string
  end
end
