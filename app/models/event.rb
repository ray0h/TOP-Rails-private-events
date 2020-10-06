class Event < ApplicationRecord
  belongs_to :creator, class_name: 'User', inverse_of: 'host_events', foreign_key: 'user_id'

  has_many :lists
  has_many :attendees, class_name: 'User', through: :lists, source: :user, foreign_key: 'user_id'

  scope :past,       -> { where('date < ?', Time.now).order(:date) }
  scope :upcoming,   -> { where('date > ?', Time.now).order(:date) }

  # class methods - refactored into scopes
  # def self.past
  #   Event.where('date < ?', Time.now)
  # end

  # def self.upcoming
  #   @upcoming = Event.where('date > ?', Time.now).order(:date)
  # end

end
