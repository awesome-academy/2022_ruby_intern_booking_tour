RSpec.describe RequestHistory, type: :model do
  describe "presence" do
    it { should validate_presence_of(:quantity, :total_price, :status)}
  end

  describe "association" do
    it { should belongs_to(:tour) }
    it { should belongs_to(:user) }
  end
end
