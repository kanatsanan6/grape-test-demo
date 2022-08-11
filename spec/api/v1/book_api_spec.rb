# frozen_string_literal: true

require 'rails_helper'

RSpec.describe V1::BookApi, type: :api do
  subject(:call) { call_api(params) }

  let(:params) { {} }

  describe 'GET /books/all' do
    it 'returns status 200' do
      expect(call.status).to eq 200
    end

    it 'returns all books' do
      json_result = JSON.parse(Book.all.to_json)
      call_body = JSON.parse(call.body)['data']
      expect(call_body).to eq json_result
    end
  end

  describe 'GET /books/:id' do
    decribe 'GET /books/1' do
      
    end
  end
end
