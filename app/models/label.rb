class Label < ApplicationRecord
  has_many :labellings, dependent: :destroy
  has_many :tasks, through: :labelings
  validates :name, uniqueness: true, presence: true
end
