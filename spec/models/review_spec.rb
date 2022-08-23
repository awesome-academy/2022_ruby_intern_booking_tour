RSpec.describe Review, type: :model do
  describe "presence" do
    it { should validate_presence_of(:rating)}
    it { should validate_presence_of(:content)}
  end

  describe "association" do
    it { should belong_to(:user) }
    it { should belong_to(:tour) }
  end
end
