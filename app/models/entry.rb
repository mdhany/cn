class Entry < ActiveRecord::Base
  belongs_to :event
  belongs_to :customer

  scope :completed, -> { where(completed: true) }
end
