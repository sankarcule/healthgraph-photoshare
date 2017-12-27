Fabricator(:post) do
  caption {Faker::StarWars.specie}
  image {Faker::LoremPixel.image('500x500', false, 'food')}
  user_id {rand(0..4)}
end
