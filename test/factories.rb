FactoryBot.define do
  factory :vehicle_category do
    sequence :name do |n|
      "Sedan #{n}"
    end
    daily_price { 3.20 }
  end

  factory :vehicle_model do
    vehicle_category { VehicleCategory.first || FactoryBot.create(:vehicle_category) }
    sequence :make do |n|
      "Ford #{n}"
    end
    sequence :name do |n|
      "Fusion #{n}"
    end
  end

  factory :vehicle do
    vehicle_model { VehicleModel.first || FactoryBot.create(:vehicle_model) }
    year { 5.years.ago.strftime("%Y").to_i + [*1..3].shuffle.pop }
    commissioned_on { rand(Date.new(year)..Date.today) }
  end

  factory :reservation do
    vehicle_category { VehicleCategory.first || FactoryBot.create(:vehicle_category) }
    start_date { 7.days.ago + ([*1..14].shuffle.pop).days }
    end_date { start_date + ([*1..14].shuffle.pop).days }
  end
end
