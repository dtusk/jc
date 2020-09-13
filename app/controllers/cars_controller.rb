# frozen_string_literal: true

class CarsController < ApplicationController
  include JSONAPI::Deserialization
  include JSONAPI::Filtering
  include JSONAPI::Pagination

  before_action :set_car, only: %i[show update destroy]

  # GET /cars
  def index
    allowed = [:title]

    jsonapi_filter(Car.all, allowed) do |filtered|
      jsonapi_paginate(filtered.result) do |paginated|
        render jsonapi: paginated
      end
    end
  end

  # GET /cars/1
  def show
    render jsonapi: @car
  end

  # POST /cars
  def create
    @car = Car.new(deserialized_parameter)

    if @car.save
      render jsonapi: @car, status: :created, location: @car
    else
      render jsonapi_errors: @car.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /cars/1
  def update
    if @car.update(deserialized_parameter)
      render jsonapi: @car
    else
      render jsonapi_errors: @car.errors, status: :unprocessable_entity
    end
  end

  # DELETE /cars/1
  def destroy
    @car.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_car
    @car = Car.find(params[:id])
  end
end
