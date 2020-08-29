RSpec.describe RSpec::Optimal::Runner do
  describe "#total_files" do
    it "returns totoal files if only one spec file is passed" do
      runner = described_class.new(["spec/mositala_spec.rb"])
      expect(runner.total_files).to match_array(["spec/mositala_spec.rb"])
    end

    it "returns totoal files if only two spec fileis is passed" do
      runner = described_class.new(["spec/mositala_spec.rb", "spec/mosi_spec.rb"])
      expect(runner.total_files).to match_array(["spec/mositala_spec.rb", "spec/mosi_spec.rb"])
    end

    it "ignores files with invalid ending" do
      runner = described_class.new(["spec/mositala"])
      expect(runner.total_files).to be_empty
    end

    it "returns total files if nothing is passed" do
      expect(Dir).to receive(:glob).and_return(["spec/mositala_spec.rb"])

      runner = described_class.new
      expect(runner.total_files).to match_array(["spec/mositala_spec.rb"])
    end
  end
end
