# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Car, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_numericality_of(:price).is_greater_than_or_equal_to(0.0) }
  end

  describe 'attributes' do
    it { is_expected.to respond_to(:title) }
    it { is_expected.to respond_to(:image_data) }
    it { is_expected.to respond_to(:description) }
    it { is_expected.to respond_to(:price) }
  end
end
