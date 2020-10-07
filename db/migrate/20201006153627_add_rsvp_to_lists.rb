class AddRsvpToLists < ActiveRecord::Migration[6.0]
  def change
    add_column :lists, :rsvp, :string, default: 'pend'
  end
end
