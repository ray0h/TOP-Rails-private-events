class Event < ApplicationRecord
  belongs_to :creator, class_name: 'User', inverse_of: 'host_events', foreign_key: 'user_id'

  has_many :lists
  has_many :invitees, through: :lists, source: :user, foreign_key: 'user_id'

  scope :past,       -> { where('date < ?', Time.now).order(:date) }
  scope :upcoming,   -> { where('date > ?', Time.now).order(:date) }

  def pending
    invitees.includes(:lists).where('lists.rsvp = ?', 'pend')
  end

  def declined
    invitees.includes(:lists).where('lists.rsvp = ?', 'no')
  end

  def confirmed
    invitees.includes(:lists).where('lists.rsvp = ?', 'yes')
  end

  # getter
  def invitee_list
    invitees.map(&:name).join(', ')
  end

  # setter (from invite form)
  def invitee_list=(invitee_list_array)
    invitee_ids = invitee_list_array
    invitee_ids.shift
    found_invitees = invitee_ids.map { |id| User.find_by(id: id) }
    self.invitees = found_invitees
  end

  def declined_list
    declined.map(&:name).join(', ')
  end

  def confirmed_list
    confirmed.map(&:name).join(', ')
  end

  # class methods - refactored into scopes
  # def self.past
  #   Event.where('date < ?', Time.now)
  # end

  # def self.upcoming
  #   @upcoming = Event.where('date > ?', Time.now).order(:date)
  # end

end
