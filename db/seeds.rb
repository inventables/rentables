# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

sedans = FactoryBot.create :vehicle_category, { name: "Sedan", daily_price: 42.42 }
suvs = FactoryBot.create :vehicle_category, { name: "SUV", daily_price: 53.53 }

ford_focus = FactoryBot.create :vehicle_model, { vehicle_category: sedans, make: "Ford", name: "Focus" }
honda_pilot = FactoryBot.create :vehicle_model, { vehicle_category: suvs, make: "Honda", name: "Pilot" }

5.times do
  FactoryBot.create :vehicle, { vehicle_model: ford_focus }
end

10.times do
  FactoryBot.create :vehicle, { vehicle_model: honda_pilot }
end

3.times do
  FactoryBot.create :reservation, { vehicle_category: sedans }
end

8.times do
  FactoryBot.create :reservation, { vehicle_category: suvs }
end
