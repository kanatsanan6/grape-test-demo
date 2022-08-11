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

      desc 'POST /books' do
        summary 'Add a new book'
      end
      params do
        requires :title, type: String, allow_blank: false
        requires :stock, type: Integer, values: -> (v) { v.positive? }, default: 1
      end
      post do
        book = Book.create!(
          title: params[:title],
          stock: params[:stock]
        )

        render_json(201, { data: book.to_json, message: 'Book created' })
      end

      desc 'PUT /books/:id' do
        summary 'update a book'
      end
      params do
        requires :id, type: Integer
        requires :title, type: String, allow_blank: false
        requires :stock, type: Integer, values: -> (v) { v.positive? }, default: 1
      end
      route_param :id do
        put do
          Book.find(params[:id]).update!(
            title: params[:title],
            stock: params[:stock]
          )

          render_json(200, { data: Book.find(params[:id]).to_json, message: 'Book updated' })
        end
      end

      desc 'DELETE /books/:id' do
        summary 'Delete a book'
      end
      params do
        requires :id, type: Integer, desc: 'Book ID'
      end
      route_param :id do
        delete do
          book = Book.find(params[:id]).destroy!

          render_json(200, { data: book.to_json, message: 'Book deleted' })
        end
      end
    end
  end
end
