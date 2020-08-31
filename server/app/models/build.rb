class Build < ApplicationRecord
  belongs_to :project

  validates :queue, presence: true, on: :create
  validates :ci, presence: true
  validates :build_number, presence: true, uniqueness: true
  validates :total_files_count, presence: true
  validates :project, presence: true
end
