RSpec.describe Category, type: :model do
  describe "presence" do
    it { should validate_presence_of(:name)}
  end

  describe "association" do
    it { should have_many(:tours).dependent(:destroy) }
  end
end
