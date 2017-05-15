Rails.application.routes.draw do
  get 'sessions/new'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
  root 'static_pages#home'
  resources :sclasses do
    post 'update_student_list' => 'sclasses#update_student_list'
    get 'missed_logs' => 'missed_logs#class_index'
    resources :topics do
      resources :reports
    end
    resources :bonus, only: [:index, :create, :destroy]
    resources :students, only: [:index]
    resources :documents
    resources :groups do
      post 'remove_group_member' => 'groups#remove_member'
      post 'add_member' => 'groups#add_member'
      post 'update_group_point' => 'groups#update_group_point'
      patch 'upload_report' => 'groups#upload_report'
      get :autocomplete_student_name, :on => :collection
    end
    resources :learnings
    resources :score_components
    resources :schedules do
      get 'missed_logs' => 'missed_logs#index'
      get '/rollup' => 'rollup#new'
      post 'rollup' => 'rollup#logging'
    end
    resources :score_tables
    resources :points
    # get '/rollup' => 'sclasses#rollup'
    # post '/rollup' => 'sclasses#process_rollup'
    post '/update_point' => 'sclasses#update_avg_point'
    post '/update_schedules' => 'schedules#update_schedules'
    post 'update_ratio' => 'sclasses#update_ratio'
    post '/update_score_table' => 'score_tables#update_score_table'
  end
  resources :learnings
  resources :mini_works
  resources :students
  resources :teachers
  resources :courses
  resources :notifications, only:[:index]
  # resources :questions
  resources :tests do
    resources :questions do
      resources :answers
    end
  end


  # post 'submit_rollup' => 'rollup#checklist'
  get '/assignment' => 'mini_works#student_index'
  get '/student/classes' => 'sclasses#student_index'
  post '/test_submit' => 'mini_works#test_submit'
  get 'month_view' => 'static_pages#month_view'
  get 'week_view' => 'static_pages#week_view'
  #admin
  get 'admin/teachers' => 'admin#teacher_index'
  get 'admin/students' => 'admin#student_index'
  get 'admin/courses' => 'admin#course_index'
  get 'admin/classes' => 'admin#class_index'
  get 'admin/courses' => 'admin#course_index'
  get 'admin/sign-in' => 'admin#sign_in'
  post 'admin/upload_courses' => 'admin#upload_courses'
  post 'admin/upload_sclasses' => 'admin#upload_sclasses'
  post 'admin/upload_students' => 'admin#upload_students'
  post 'admin/upload_teachers' => 'admin#upload_teachers'
  get 'admin/change_password' => 'admin#change_password'
  post 'admin/change_password' => 'admin#change_password'
  #--admin--

  get    'login'   => 'sessions#new'
  post   'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'
  get 'date_time_table/:date' => 'schedules#date_time_table'

end
