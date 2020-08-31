RSpec.describe Project, type: :model do
  it "validates name" do
    expect(Project.new).not_to be_valid
    expect(Project.new(token: '111')).not_to be_valid

    expect(Project.create(name: 'NAME', token: '111')).to be_valid
    expect(Project.new(name: 'NAME', token: '222')).not_to be_valid
  end
end
