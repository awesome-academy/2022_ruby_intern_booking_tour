RSpec.describe Tour, type: :model do
  let(:category) {
    FactoryBot.create :category
  }

  let(:tour_1){
    FactoryBot.create :tour_example_1, category: category
  }

  let(:tour_2){
    FactoryBot.create :tour_example_2, category: category
  }

  describe "presence" do
    it { should validate_presence_of(:name)}
    it { should validate_presence_of(:description)}
    it { should validate_presence_of(:start_date)}
    it { should validate_presence_of(:price)}
    it { should validate_presence_of(:stock)}
    it { should validate_presence_of(:avg_rating)}
  end

  describe "association" do
    it { should have_many(:tour_requests).dependent(:destroy) }
    it { should have_many(:reviews).dependent(:destroy) }
    it { should belong_to(:category) }
  end

  describe "check scope" do
    context "orders by id ascending" do
      it "Should order by id" do
        expect(Tour.incre_order).to eq([tour_1, tour_2])
      end
    end

    context "order by rating" do
      it "Should order by rating" do
        expect(Tour.order_rating(1)).to eq([tour_1, tour_2])
      end
    end

    context "by start date" do
      it "Should search by start date" do
        expect(Tour.by_start_date(Time.zone.parse('2022-10-11 21:00'))).to eq([])
      end
    end

    context "by end date" do
      it "Should search by end date" do
        expect(Tour.by_end_date(Time.zone.parse('2022-11-11 21:00'))).to eq([tour_1, tour_2])
      end
    end

    context "by most name" do
      it "Should search by name" do
        expect(Tour.by_most_name("Tour2")).to eq([tour_2])
      end
    end

    context "by_rating_array" do
      it "Should search by rating array" do
        expect(Tour.by_rating_array(1)).to eq([tour_1, tour_2])
      end
    end

    context "by_start_price" do
      it "Should search by start price" do
        expect(Tour.by_start_price(1)).to eq([tour_1, tour_2])
      end
    end

    context "by_end_price" do
      it "Should search by end price" do
        expect(Tour.by_end_price(1)).to eq([tour_1, tour_2])
      end
    end

    context "by avg rating" do
      it "Should search by avg rating" do
        expect(Tour.by_avg_ratings(1)).to eq([tour_1, tour_2])
      end
    end

    context "order by name" do
      it "ascending" do
        expect(Tour.order_by_name("asc")).to eq([tour_1, tour_2])
      end

      it "descending" do
        expect(Tour.order_by_name("desc")).to eq([tour_2, tour_1])
      end
    end

    context "order by price" do
      it "ascending" do
        expect(Tour.order_by_price("asc")).to eq([tour_1, tour_2])
      end

      it "descending" do
        expect(Tour.order_by_price("desc")).to eq([tour_1, tour_2])
      end
    end
  end

  describe "search" do
    it "search" do
      expect(Tour.search(nil, nil, nil, nil, nil, "Tour2", nil, nil)).to eq([tour_2])
      expect(Tour.search("2022-11-11 21:00", nil, nil, nil, nil, "Tour2", nil, nil)).to eq([])
      expect(Tour.search(nil, "2022-11-11 21:00", nil, nil, nil, "Tour2", nil, nil)).to eq([tour_2])
      expect(Tour.search(nil, nil, 1, nil, nil, "Tour1", nil, nil)).to eq([tour_1])
      expect(Tour.search(nil, nil, nil, 1, nil, "Tour2", nil, nil)).to eq([tour_2])
    end
  end
end
