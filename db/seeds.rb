require "faker"

# SEED RESTAURANTS
3.times do
  restaurant = Restaurant.create!(
    name: Faker::Restaurant.name:,
    address: Faker::Address.full_address,
    phone_number: Faker::PhoneNumber.cell_phone
  )
puts "Restaurant #{restaurant.id} has been created."
end

# SEED SUPPLIERS
SUPPLIER_COMMENTS = [
  "Delivers in the first week of each month",
  "Delivery only for 500+ bottles",
  "Closed on weekends",
  "No Amex",
  "Doesn't sell Spanish brands"
]

10.times do
  supplier = Supplier.create!(
    name: Faker::Bank.name,
    phone_number: Faker::Bank.account_number(digits: 10),
    email: Faker::Internet.email(name: 'info'),
    contact_full_name: Faker::Name.name,
    contact_phone_number: Faker::Bank.account_number(digits: 10),
    contact_email: Faker::Internet.email,
    comment: SUPPLIER_COMMENTS.sample,
    restaurant: Restaurant.all.sample

  )
  puts "Supplier #{supplier.id} has been created."
end

# SEED STORAGE LOCATIONS A.K.A FRIDGES
20.times do
  n = 0
  storage_location = StorageLocation.create!(
    name: "Fridge #{n}",
    address: Faker::Address.full_address,
    capacity: 100,
    temperature: ["A", "B"].sample,
    restaurant: Restaurant.all.sample
  )
  n += 1
  puts "Storage location #{storage_location.id} has been created."
end

# SEED WINES
WINE_BRANDS = [
  "Familia Torres",
  "Bodega Catena",
  "Vega Sicilia",
  "Henschke",
  "Concha y Toro",
  "Penfolds",
  "Domaine de la Romanée Conti",
  "CVNE",
  "Antinori",
  "Chateau Musar"
]

WINE_COUNTRIES = ["France", "Lebanon", "Spain", "Australia", "Italy", "Argentina", "Chile"]

# Work in progress
200.times do
  wine = Wine.create!(
    maker: WINE_BRANDS.sample,
    country: WINE_COUNTRIES.sample,
    vintage: rand(2000..2023),
    colour: ["red", "white", "rose"],
    region: ,
    appellation:,
    volume:,
    cuvee:,
    grape_variety:,
    supplier:,
    unit_price:,
    avg_price:,
    quantity: 0,
    restaurant:,
  )
  puts "Wine #{wine.id} has been created"
end
