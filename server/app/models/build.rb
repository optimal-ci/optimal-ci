class Build < ApplicationRecord
  validates :queue, presence: true
  validates :ci, presence: true
  validates :build_number, presence: true
  validates :total_files_count, presence: true
end
