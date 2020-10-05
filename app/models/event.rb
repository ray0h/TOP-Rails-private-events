class Event < ApplicationRecord
  belongs_to :creator, class_name: 'User', inverse_of: 'host_events', foreign_key: 'user_id'

  has_many :lists
  has_many :attendees, class_name: 'User', through: :lists, source: :user, foreign_key: 'user_id'
end
