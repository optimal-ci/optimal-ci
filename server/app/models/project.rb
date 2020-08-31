class Project < ApplicationRecord
  has_many :builds

  validates :name, presence: true, uniqueness: true
  validates :token, uniqueness: true
end
