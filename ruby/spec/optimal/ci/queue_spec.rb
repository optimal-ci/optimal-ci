RSpec.describe Optimal::CI::Queue do
  let(:provider) { double(build_number: Faker::Number.number, name: 'travis', node_index: 1, total_nodes: 2) }
  let(:queue) { described_class.new(provider) }

  describe "#push" do
    it 'sends files to the server' do
      expect(ENV).to receive(:[]).twice.with('OPTIMAL_CI_TOKEN').and_return("something")
      expect(ENV).to receive(:[]).twice.with('OPTIMAL_CI_URL').and_return("something")

      expect(RestClient).to receive(:post).and_return(double(code: 204))

      expect(queue.push(['spec/mositala_spec.rb'])).to eq(true)
    end
  end


  describe "#pop" do
    it "returns array of one file" do
      expect(ENV).to receive(:[]).twice.with('OPTIMAL_CI_TOKEN').and_return("something")
      expect(ENV).to receive(:[]).twice.with('OPTIMAL_CI_URL').and_return("something")

      expect(RestClient).to receive(:get).and_return(double(code: 200, body: "[\"spec/mositala_spec.rb\"]"))

      expect(queue.pop).to eq(['spec/mositala_spec.rb'])
    end
  end
end
