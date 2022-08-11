# frozen_string_literal: true

Rails.application.routes.draw do
  mount V1::API => '/api/v1'
  mount Rswag::Ui::Engine => '/api/documentation'
end
