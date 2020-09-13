# frozen_string_literal: true

class ApplicationController < ActionController::API
  protected

  def deserialized_parameter
    @deserialized_parameter ||= jsonapi_deserialize(params)
  end

  def jsonapi_meta(resources)
    meta = {}

    pagination = jsonapi_pagination_meta(resources)

    if pagination.present? && params['page'].present?
      meta[:pagination] = pagination
      meta[:page_size] = jsonapi_pagination_params.second
    end

    meta[:total_count] = resource_counter(resources) if resources.respond_to?(:size)

    meta
  end

  private

  def resource_counter(resources)
    if resources.respond_to?(:unscope)
      resources.unscope(:limit, :offset).count
    else
      resources.instance_variable_get(:@original_size) || resources.size
    end
  end
end
