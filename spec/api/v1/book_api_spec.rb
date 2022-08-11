# frozen_string_literal: true

require 'rails_helper'

RSpec.describe V1::BookAPI, type: :api do
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
    describe 'GET /books/1' do
      it 'returns status 200' do
        expect(call.status).to eq 200
      end

      it 'returns a book' do
        json_result = JSON.parse(Book.find(1).to_json)
        call_body = JSON.parse(call.body)['data']
        expect(call_body).to eq json_result
      end
    end

    describe 'GET /books/99999999' do
      it 'returns status 404' do
        expect(call.status).to eq 404
      end

      it 'returns 404 not found' do
        call_body = JSON.parse(call.body)['errors']
        expect(call_body).to eq '404 not found'
      end
    end

    describe 'GET /books/invalid' do
      it 'returns status 400' do
        expect(call.status).to eq 400
      end

      it 'returns id is invalid' do
        call_body = JSON.parse(call.body)['error']
        expect(call_body).to eq 'id is invalid'
      end
    end
  end

  describe 'POST /books' do
    let(:params) { { title: 'test', stock: 1 } }

    it 'returns status 201' do
      expect(call.status).to eq 201
    end

    it 'returns success msg and the book' do
      call_message = JSON.parse(call.body)['message']
      call_data = JSON.parse(JSON.parse(call.body)['data'])

      expect(call_message).to eq 'Book created'
      expect(call_data['title']).to eq params[:title]
      expect(call_data['stock']).to eq params[:stock]
    end

    it 'returns status 400 and error message' do
      params[:stock] = 0
      call_body = JSON.parse(call.body)['error']

      expect(call.status).to eq 400
      expect(call_body).to eq 'stock does not have a valid value'
    end

    it 'returns status 400 and error message' do
      params[:title] = ''
      call_body = JSON.parse(call.body)['error']

      expect(call.status).to eq 400
      expect(call_body).to eq 'title is empty'
    end
  end

  describe 'PUT /books/:id' do
    let(:params) { { title: 'updated', stock: 100 } }

    describe 'PUT /books/1' do
      it 'returns status 200' do
        expect(call.status).to eq 200
      end

      it 'returns updated book' do
        call_message = JSON.parse(call.body)['message']
        call_data = JSON.parse(JSON.parse(call.body)['data'])

        expect(call_message).to eq 'Book updated'
        expect(call_data['title']).to eq params[:title]
        expect(call_data['stock']).to eq params[:stock]
      end
    end

    describe 'PUT /books/99999999' do
      it 'returns status 404' do
        expect(call.status).to eq 404
      end

      it 'returns 404 not found' do
        call_body = JSON.parse(call.body)['errors']
        expect(call_body).to eq '404 not found'
      end
    end

    describe 'PUT /books/invalid' do
      it 'returns status 400' do
        expect(call.status).to eq 400
      end

      it 'returns id is invalid' do
        call_body = JSON.parse(call.body)['error']
        expect(call_body).to eq 'id is invalid'
      end
    end
  end

  describe 'DELETE /books/:id' do
    describe 'DELETE /books/1' do
      it 'returns status 200' do
        expect(call.status).to eq 200
      end

      it 'returns deleted book' do
        json_result = JSON.parse(Book.find(1).to_json)
        call_message = JSON.parse(call.body)['message']
        call_data = JSON.parse(JSON.parse(call.body)['data'])

        expect(call_message).to eq 'Book deleted'
        expect(call_data).to eq json_result
      end
    end

    describe 'DELETE /books/99999999' do
      it 'returns status 404' do
        expect(call.status).to eq 404
      end

      it 'returns 404 not found' do
        call_body = JSON.parse(call.body)['errors']
        expect(call_body).to eq '404 not found'
      end
    end

    describe 'DELETE /books/invalid' do
      it 'returns status 400' do
        expect(call.status).to eq 400
      end

      it 'returns id is invalid' do
        call_body = JSON.parse(call.body)['error']
        expect(call_body).to eq 'id is invalid'
      end
    end
  end
end
