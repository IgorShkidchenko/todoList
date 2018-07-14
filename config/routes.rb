# frozen_string_literal: true

Rails.application.routes.draw do
  root 'home#index'

  devise_for :users

  resources :projects do
    resources :tasks
  end

  get '/projects/:project_id/tasks/:id/complete', to: 'tasks#complete', as: 'complete'
  patch '/projects/:project_id/tasks/:id/sortUp', to: 'tasks#sort_up', as: 'sortUp'
  patch '/projects/:project_id/tasks/:id/sortDown', to: 'tasks#sort_down', as: 'sortDown'
  delete '/projects/:project_id/tasks/:id', to: 'tasks#destroy', as: 'del'
end
