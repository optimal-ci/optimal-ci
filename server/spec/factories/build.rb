FactoryBot.define do
  factory :build do
    build_number        { Faker::Number.number }
    ci                  { 'travis '}
    queue               { %w[spec/mosi_spec.rb spec/felan_spec.rb] }
    total_files_count   { 2 }
  end
end
