class Course < ActiveRecord::Base
  has_and_belongs_to_many :users, :uniq => true
  has_and_belongs_to_many :events, :uniq => true

  include PgSearch
  pg_search_scope :search,
                  :against => [[:name, 'A'], [:abbr, 'A'], [:short_code, 'C']],
                  :using => {:tsearch => {:prefix => true, :normalization => 2}}

  attr_accessible :name, :abbr, :short_code

  def title_name
    name.humanize.titleize
  end
end
