class Event < ApplicationRecord
  belongs_to :creator, class_name: 'User', inverse_of: 'host_events', foreign_key: 'user_id'
end