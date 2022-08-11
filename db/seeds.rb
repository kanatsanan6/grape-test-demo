# frozen_string_literal: true

15.times do
  Book.create!(title: Faker::Superhero.power, stock: Faker::Number.between(2, 19))
end
