Rails.application.routes.draw do
  devise_for :users

  root to: "courses#home"
  scope '/admin' do
    get '/courses', to: 'courses#admin_index', as: "admin_index"
  end

  scope '/student' do
    get '/courses', to: 'courses#student_index', as: "student_index"
  end

  scope '/teacher' do
    get '/courses/:id', to: 'courses#show', as: 'course'
    get '/courses', to: 'courses#teacher_index', as: 'teacher_index'
    resources :grades, only: [:create, :destroy, :edit, :update]
  end
end
