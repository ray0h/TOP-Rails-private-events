class User < ApplicationRecord
  has_many :host_events, class_name: 'Event', inverse_of: 'creator'
end
