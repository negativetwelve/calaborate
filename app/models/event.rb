class Event < ActiveRecord::Base
  include PgSearch
  pg_search_scope :search,
                  :against => [[:course_name, 'A'], [:name, 'A'], [:course_abbr, 'B'], [:course_short_code, 'C']],
                  :using => {:tsearch => {:prefix => true, :normalization => 2}}


  has_and_belongs_to_many :users, :uniq => true
  has_and_belongs_to_many :courses, :uniq => true

  has_many :rsvps
  has_many :attending, through: :rsvps, source: :user

  validates_presence_of :name, :start_time, :end_time, :location

  attr_accessible :end_time, :name, :start_time, :more_info, :location

  default_scope order('start_time')

  scope :upcoming, where('start_time > ?', DateTime.now - 7.hours)
  scope :today, where('start_time BETWEEN ? AND ?', (DateTime.now - 7.hours).beginning_of_day, (DateTime.now - 7.hours).end_of_day).order(:start_time)
  scope :tomorrow, where('start_time BETWEEN ? AND ?', (DateTime.now - 7.hours).beginning_of_day + 1.day, (DateTime.now - 7.hours).end_of_day + 1.day).order(:start_time)
  scope :this_week, where('start_time BETWEEN ? AND ?', (DateTime.now - 7.hours).beginning_of_day + 2.days, (DateTime.now - 7.hours).end_of_day + 7.days).order(:start_time)
  scope :rest_upcoming, where('start_time > ?', (DateTime.now - 7.hours).end_of_day + 7.days).order(:start_time)

  scope :by_course, lambda { |course_id| 
          joins(:courses).
          where('course_id = ?', course_id)
        }

  self.per_page = 30

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
