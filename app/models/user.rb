class User < ApplicationRecord
  has_many :host_events, class_name: 'Event', inverse_of: 'creator'

  has_many :lists
  has_many :invitations, class_name: 'Event', through: :lists, source: :event, foreign_key: 'event_id'

  def pending_events
    invitations.includes(:lists).where('lists.rsvp = ?', 'pend')
  end

  def declined_events
    invitations.includes(:lists).where('lists.rsvp = ?', 'no')
  end

  def attended_events
    invitations.includes(:lists).where('lists.rsvp = ?', 'yes')
  end
end
