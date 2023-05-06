require "faker"

# CLEAN UP DATABASE
puts "Deleting all wines"
Wine.destroy_all

puts "Deleting all storages"
StorageLocation.destroy_all

puts "Deleting all restaurants"
Restaurant.destroy_all

puts "Deleting all suppliers"
Supplier.destroy_all

# SEED RESTAURANTS
3.times do
  restaurant = Restaurant.create!(
    name: Faker::Restaurant.name,
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
    comment: SUPPLIER_COMMENTS.sample
  )
  puts "Supplier #{supplier.id} has been created."
end

# SEED STORAGE LOCATIONS A.K.A FRIDGES
n = 0
20.times do
  storage_location = StorageLocation.create!(
    name: "Fridge #{n}",
    address: Faker::Address.full_address,
    capacity: 100,
    temperature: ["cold", "room"].sample,
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
    colour: ["Red", "White", "Rose", "Sparkling", "Sweet"].sample,
    region: ["Bordeaux", "Burgundy", "Piemonte", "Omina Romana", "Sicilia", "Bekaa Valley", "Mendoza"].sample,
    appellation: ["Margaux", "Pessac-Leognan", "Gevrey-Chambertin", "Pommard", "Saint-Joseph", "Champagne"].sample,
    volume: ["Bottle", "Magnum", "Half-Bottle"].sample,
    cuvee: ["Love coding", "Cuvee Ruby", "Rails Romance", "Javascript", "Clos Le-Wagon", "Grand Cru Bootstrap"].sample,
    grape_variety: ["Chardonnay", "Pinot Noir", "Syrah", "Sauvignon", "Chenin Blanc", "Merlot", "Vermentino"].sample,
    supplier: Supplier.all.sample,
    unit_price: rand(10..250),
    avg_price: rand(10..350),
    quantity: rand(1..6),
    restaurant: Restaurant.all.sample
  )
  wine.update(
    maker_list: wine.maker,
    country_list: wine.country,
    vintage_list: wine.vintage,
    region_list: wine.region,
    appellation_list: wine.appellation,
    cuvee_list: wine.cuvee
  )
  puts "Wine #{wine.id} has been created"
end
