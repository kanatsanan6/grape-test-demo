# frozen_string_literal: true

require 'grape-swagger'

module V1
  class API < Grape::API
    format :json
    content_type :json, 'application/json; charset=utf-8'
    version 'v1', using: :header, vendor: 'datawow'

    rescue_from ActiveRecord::RecordNotFound do
      error!({ errors: '404 not found' }, 404)
    end

    helpers V1::Helpers::ResponseHelper

    mount V1::BookAPI

    add_swagger_documentation(
      api_version: 'v1',
      base_path: '/api/v1',
      doc_version: 1,
      info: { title: 'API V1' },
      mount_path: '/',
      security_definitions: {
        authorization: {
          type: 'apiKey',
          name: 'Authorization',
          in: 'header'
        }
      },
      security: [
        {
          authorization: []
        }
      ]
    )
  end
end
