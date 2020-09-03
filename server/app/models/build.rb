class Build < ApplicationRecord
  belongs_to :project
  has_many :nodes

  validates :queue, presence: true, on: :create
  validates :ci, presence: true
  validates :build_number, presence: true, uniqueness: { scope: :project_id }
  validates :total_files_count, presence: true
  validates :project, presence: true
end
