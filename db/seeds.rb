# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

1.times do
  user = User.create(login: SecureRandom.hex)
  group = Group.create(name: 'test_name', description: 'test_description', user: user)
  Card.create(word: "test_word", definition: "test_definition", example: "test_example", group: group)
end
