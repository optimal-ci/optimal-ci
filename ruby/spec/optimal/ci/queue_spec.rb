RSpec.describe Optimal::CI::Queue do
  let(:build_number) { Faker::Number.number }
  let(:queue) { described_class.new(build_number) }

  describe "#push" do
    it 'sends files to the server' do
      expect(queue.push(['spec/mositala_spec.rb'])).to eq(true)
    end
  end
end
