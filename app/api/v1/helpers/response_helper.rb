# frozen_string_literal: true

module V1::Helpers::ResponseHelper
  extend Grape::API::Helpers

  def render_json(code, data = {})
    error!(data, code) if code >= 400

    status code
    present data
  end
end
