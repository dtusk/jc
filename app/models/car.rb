# frozen_string_literal: true

class Car < ApplicationRecord
  include ImageUploader::Attachment(:image)

  validates :title, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0.0 }
end
