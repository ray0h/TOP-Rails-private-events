class User < ApplicationRecord
  has_many :host_events, class_name: 'Event', inverse_of: 'creator'

  has_many :lists
  has_many :attended_events, class_name: 'Event', through: :lists, source: :event, foreign_key: 'event_id'
end
