FactoryGirl.define do
  factory :post do
    caption {Faker::StarWars.specie}
    image {Faker::LoremPixel.image('500x500', false, 'food')}
    user_id {User.last.id}
  end
end
