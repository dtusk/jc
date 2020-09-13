# frozen_string_literal: true

class ApplicationSerializer
  include FastJsonapi::ObjectSerializer

  attribute :created_at
  attribute :updated_at

  def self.url_helpers
    @url_helpers ||= Rails.application.routes.url_helpers
  end
end
