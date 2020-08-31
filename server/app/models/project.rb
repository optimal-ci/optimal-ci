class Project < ApplicationRecord
    validates :name, presence: true, uniqueness: true
    validates :token, uniqueness: true
end
