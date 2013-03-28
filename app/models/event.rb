class Event < ActiveRecord::Base
  has_and_belongs_to_many :users, :uniq => true
  has_and_belongs_to_many :courses, :uniq => true

  attr_accessible :end_time, :name, :start_time, :more_info, :location

  scope :by_course, lambda { |course_id| 
          joins(:courses).
          where('course_id = ?', course_id)
        }
end
