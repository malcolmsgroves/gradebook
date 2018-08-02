Rails.application.routes.draw do
  devise_for :users

  scope '/admin' do
    get '/courses', to: 'courses#admin_index', as: "admin_index"
  end

  scope '/student' do
    get '/:id/courses', to: 'courses#student_index', as: "student_courses"
  end

  scope '/teacher' do
    get '/courses/:id', to: 'courses#show', as: 'course'
    get '/:id/courses', to: 'courses#teacher_index', as: 'teacher_courses'
    resources :grades, only: [:create, :destroy, :edit]
  end
end
