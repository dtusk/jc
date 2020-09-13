# frozen_string_literal: true

require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to test the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator. If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails. There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.

RSpec.describe '/cars', type: :request do
  # This should return the minimal set of attributes required to create a valid
  # Car. As you add validations to Car, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) { attributes_for(:car, :with_base64_image) }

  let(:invalid_attributes) { attributes_for(:car, :with_false_upload, title: nil) }

  describe 'GET /index' do
    it 'renders a successful response' do
      Car.create! valid_attributes
      get cars_url, as: :json
      expect(response).to be_successful
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      car = Car.create! valid_attributes
      get car_url(car), as: :json
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new Car' do
        expect do
          post cars_url,
               params: request_body(valid_attributes), as: :json
        end.to change(Car, :count).by(1)
      end

      it 'renders a JSON response with the new car' do
        post cars_url,
             params: request_body(valid_attributes), as: :json
        expect(response).to have_http_status(:created)
        expect(response.content_type)
          .to match(a_string_including('application/vnd.api+json'))
      end
    end

    context 'with invalid parameters' do
      let(:error_file) { Rails.root.join('spec', 'data', 'cars', 'error_message.json') }
      let(:error_message) { JSON.parse(File.read(error_file)) }

      it 'does not create a new Car' do
        expect do
          post cars_url, params: request_body(invalid_attributes), as: :json
        end.to change(Car, :count).by(0)
      end

      it 'renders a JSON response with errors for the new car' do
        post cars_url, params: request_body(invalid_attributes), as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type)
          .to match(a_string_including('application/vnd.api+json'))
        expect(json_response).to eq(error_message)
      end
    end
  end

  describe 'PATCH /update' do
    context 'with valid parameters' do
      let(:new_attributes) do
        { title: 'Foo bar 123' }
      end

      it 'updates the requested car' do
        car = Car.create! valid_attributes
        patch car_url(car), params: request_body(new_attributes), as: :json
        car.reload
        expect(car.title).to eq('Foo bar 123')
      end

      it 'renders a JSON response with the car' do
        car = Car.create! valid_attributes
        patch car_url(car), params: request_body(new_attributes), as: :json
        expect(response).to have_http_status(:ok)
        expect(response.content_type)
          .to match(a_string_including('application/vnd.api+json'))
      end
    end

    context 'with invalid parameters' do
      it 'renders a JSON response with errors for the car' do
        car = Car.create! valid_attributes
        patch car_url(car), params: request_body(invalid_attributes), as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type)
          .to match(a_string_including('application/vnd.api+json'))
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested car' do
      car = Car.create! valid_attributes
      expect do
        delete car_url(car), as: :json
      end.to change(Car, :count).by(-1)
    end
  end

  def request_body(params)
    {
      data: {
        attributes: params
      }
    }
  end
end
