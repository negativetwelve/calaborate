class Rsvp < ActiveRecord::Base
  belongs_to :user
  belongs_to :event

  attr_accessible :event_id, :inviter_id, :status, :user_id

  validates_presence_of :user_id, :event_id

  scope :attending, where(status: 'attending')
  scope :maybe_attending, where(status: 'maybe attending')
  scope :not_attending, where(status: 'not attending')

  def self.is_going?(user, event)
    rsvp = find_by_user_id_and_event_id(user, event)
    if rsvp.nil?
      return false
    elsif rsvp.status == 'attending'
      return true
    end
    false
  end

  def self.attend(user, event)
    return false if is_going?(user, event)
    rsvp = new(user_id: user.id, event_id: event.id, status: 'attending')
    transaction do
      rsvp.save
    end
  end

  def self.maybe(user, event)
    rsvp = new(user_id: user.id, event_id: event.id, status: 'maybe attending')
    transaction do
      rsvp.save
    end
  end

end
