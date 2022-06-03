class Client < ApplicationRecord
  has_many :memberships
  has_many :gyms, through: :memberships

  validates :name, presence: true
  validates :age, numericality: true

  attribute :total_amount

  def total_amount
    self.memberships.map(&:charge).sum
  end
end
