class AddCourseAbbrToEvents < ActiveRecord::Migration
  def change
    add_column :events, :course_abbr, :string
    add_column :events, :course_short_code, :string
  end
end
