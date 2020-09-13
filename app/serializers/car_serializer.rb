# frozen_string_literal: true

class CarSerializer < ApplicationSerializer
  set_type :cars

  attribute :title
  attribute :description
  attribute :price

  link :self do |object|
    url_helpers.car_url(id: object.id)
  end

  link :image do |object|
    object.image_url if object.image.present?
  end
end
