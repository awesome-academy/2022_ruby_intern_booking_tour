RSpec.describe User, type: :model do

  let(:user_1){
    FactoryBot.create :user_example1
  }

  let(:user_2){
    FactoryBot.create :user_example2,
  }

  describe "presence" do
    it { should validate_presence_of(:name)}
    it { should validate_presence_of(:email)}
    it { should validate_presence_of(:password)}
    it { should validate_presence_of(:activated)}
  end

  describe "association" do
    it { should have_many(:tour_requests).dependent(:destroy) }
    it { should have_many(:reviews).dependent(:destroy) }
  end

  describe "check scope" do
    it "orders by created at" do
      expect(User.lastest).to eq([user_2, user_1])
    end
  end
end
