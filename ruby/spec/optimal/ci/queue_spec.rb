RSpec.describe Optimal::CI::Queue do
  let(:build_number) { Faker::Number.number }
  let(:queue) { described_class.new(build_number) }

  describe "#push" do
    it 'sends files to the server' do
      expect(ENV).to receive(:[]).twice.with('OPTIMAL_CI_TOKEN').and_return("something")
      expect(ENV).to receive(:[]).twice.with('OPTIMAL_CI_URL').and_return("something")

      expect(RestClient).to receive(:post).and_return(double(code: 204))

      expect(queue.push(['spec/mositala_spec.rb'])).to eq(true)
    end
  end
end
