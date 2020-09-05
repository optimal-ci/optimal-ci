RSpec.describe RSpec::Optimal::Runner do
  describe "#total_files" do
    let(:time) { Time.now }

    before do
      allow(File).to receive(:mtime).and_return(time)
    end

    it "returns totoal files if only one spec file is passed" do
      runner = described_class.new(["spec/mositala_spec.rb"])
      expect(runner.total_files).to match({"spec/mositala_spec.rb" => [time.to_i]})
    end

    it "returns totoal files if only two spec fileis is passed" do
      runner = described_class.new(["spec/mositala_spec.rb", "spec/mosi_spec.rb"])
      expect(runner.total_files).to match({"spec/mositala_spec.rb" => [time.to_i], "spec/mosi_spec.rb" => [time.to_i]})
    end

    it "ignores files with invalid ending" do
      runner = described_class.new(["spec/mositala"])
      expect(runner.total_files).to be_empty
    end

    it "returns total files if nothing is passed" do
      expect(Dir).to receive(:glob).and_return(["spec/mositala_spec.rb"])

      runner = described_class.new
      expect(runner.total_files).to match({"spec/mositala_spec.rb" => [time.to_i]})
    end

    it "returns total files if a directory is passed" do
      expect(Dir).to receive(:glob).and_return(["spec/mositala_spec.rb"])

      runner = described_class.new(["spec/"])
      expect(runner.total_files).to match({"spec/mositala_spec.rb" => [time.to_i]})
    end
  end
end
