class Event < ActiveRecord::Base
  has_and_belongs_to_many :users, :uniq => true
  has_and_belongs_to_many :courses, :uniq => true

  has_many :rsvps

  validates_presence_of :name, :start_time, :end_time, :location

  attr_accessible :end_time, :name, :start_time, :more_info, :location

  scope :by_course, lambda { |course_id| 
          joins(:courses).
          where('course_id = ?', course_id)
        }

  def start_time_formatted
    start_time.strftime("%a %b %d")
  end

  def start_formatted_time
    start_time.strftime("%l:%M%P")
  end

  def end_formatted_time
    end_time.strftime("%l:%M%P")
  end

  def end_time_formatted
    end_time.strftime("%a, %b, %d at %l:%M %p")
  end

end
