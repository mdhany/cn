class Customer < ActiveRecord::Base
  has_one :entry

  validate :email, :birth, presence: true, uniqueness: true

  def self.get_customer(email)
    customer = find_by email: email
    if customer
      customer
    else
      nil
    end
  end

end
