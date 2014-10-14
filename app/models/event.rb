class Event < ActiveRecord::Base
  has_many :entries
  has_many :gifts
  has_many :collectors
end
