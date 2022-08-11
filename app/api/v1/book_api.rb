# frozen_string_literal: true

module V1
  class BookAPI < Grape::API
    resources :books do
      desc 'GET /books/all' do
        summary 'Get all books'
      end
      get :all do
        data = {
          data: Book.all
        }
        render_json(200, data)
      end

      desc 'GET /books/id' do
        summary 'Get a book'
      end
      params do
        requires :id, type: Integer, desc: 'Book ID'
      end
      route_param :id do
        get do
          data = {
            data: Book.find(params[:id])
          }
          render_json(200, data)
        end
      end
    end
  end
end
