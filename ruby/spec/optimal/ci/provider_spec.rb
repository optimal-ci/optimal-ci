RSpec.describe Optimal::CI::Provider do
  describe "#detect" do
    it "returns detected provider" do
      ENV['TRAVIS_BUILD_NUMBER'] = '20'

      provider = described_class.detect

      expect(provider).not_to           be_nil
      expect(provider.name).to          eq('travis')
      expect(provider.build_number).to  eq('20')

      ENV['TRAVIS_BUILD_NUMBER'] = nil
    end
  end
end
