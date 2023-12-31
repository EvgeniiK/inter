Rails.application.routes.draw do
  resources :teachers do
    resources :teacher_subjects, shallow: true
  end
  resources :subjects
  resources :sections, only: :index
  resources :student_sections, only: [:index, :create, :destroy]

  root to: 'subjects#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
