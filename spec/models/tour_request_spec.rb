RSpec.describe TourRequest, type: :model do
  describe "presence" do
    it { should validate_presence_of(:status)}
    it { should validate_presence_of(:quantity)}
  end

  describe "association" do
    it { should belong_to(:user) }
    it { should belong_to(:tour) }
  end
end
