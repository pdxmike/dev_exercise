# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
def random_password
  rand(100000...900000).to_s
end

def random_org_id
  Organization.all.sample.id
end

def random_user_id
  User.all.sample.id
end

user_seeds = [
  {first_name: "Dev", last_name: "Challenger", email: "dev@dundermifflin.com", password: "password1234", password_confirmation: "password1234"},
  {first_name: "Jim", last_name: "Halpert", email: "jim@dundermifflin.com", password: random_password},
  {first_name: "Pam", last_name: "Halpert", email: "pam@dundermifflin.com", password: random_password},
  {first_name: "Michael", last_name: "Scott", email: "michael@dundermifflin.com", password: random_password},
  {first_name: "Dwight", last_name: "Schrute", email: "dwight@dundermifflin.com", password: random_password},
  {first_name: "Kevin", last_name: "Malone", email: "kevin@dundermifflin.com", password: random_password},
  {first_name: "Andrew", last_name: "Bernard", email: "andy@dundermifflin.com", password: random_password},
  {first_name: "Stanley", last_name: "Hudson", email: "stanley@dundermifflin.com", password: random_password},
  {first_name: "Phyllis", last_name: "Vance", email: "phyllis@dundermifflin.com", password: random_password},
]

user_seeds.each do |user_seed|
  puts "Creating #{user_seed[:first_name]} #{user_seed[:last_name]} using the password #{user_seed[:password]} : #{user_seed[:password]}"
  user = User.create(first_name: user_seed[:first_name], last_name: user_seed[:last_name], email: user_seed[:email], password: user_seed[:password], password_confirmation: user_seed[:password])
end

puts "Creating Organizations"
40.times do
  org = Organization.create(name: Faker::Company.name, description: Faker::Lorem.paragraph_by_chars)
end

puts "Creating Memberships"
60.times do
  membership = Membership.create(organization_id: random_org_id, user_id: random_user_id)
end
