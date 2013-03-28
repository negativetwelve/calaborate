class Course < ActiveRecord::Base
  has_and_belongs_to_many :users, :uniq => true
  has_and_belongs_to_many :events, :uniq => true

  attr_accessible :name

  def title_name
    name.humanize.titleize
  end
end
