class CreateEventsCoursesTable < ActiveRecord::Migration
  def up
    create_table :courses_events, :id => false do |t|
        t.references :course
        t.references :event
    end
    add_index :courses_events, [:course_id, :event_id]
    add_index :courses_events, [:event_id, :course_id]
  end

  def down
    drop_table :courses_events
  end
end
