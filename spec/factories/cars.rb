# frozen_string_literal: true

FactoryBot.define do
  factory :car do
    title { 'Sprzedam opla' }
    description { 'Dobry opel w dobrej cenie' }
    price { '90000.99' }

    trait :with_base64_image do
      image_data_uri { 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAUA' }
    end

    trait :with_false_upload do
      image_data_uri { 'data:text/plain;base64,MQo=' }
    end
  end
end
