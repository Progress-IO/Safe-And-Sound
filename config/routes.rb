Rails.application.routes.draw do
  resources :security_news
    # devise_for :admins
    # resources :admins, :except => [:delete]
    # resources :users, :except => [:delete]
    # get 'user_panel/index'
    devise_for :users,:controllers => {:omniauth_callbacks => "users/omniauth_callbacks"},  path: 'auth', path_names: { sign_in: 'login', sign_out: 'logout', registration: 'register' }
    get '/users_panel/report' =>'user_panel#report', :as => :report_type

    get "landing_page/contact", as: "contact"
    get 'reports' => 'reports#index', :as => :reports_list;

    root 'landing_page#index'
    resources :users, except:[:destroy]


    authenticate :user do
        resources :routes, :except => [:delete]
        resources :suspects, :except => [:delete]
        resources :reports, :except => [:delete]
        resources :discussions, :except => [:delete]
        resources :transports, :except => [:delete]
        get '/users_panel' =>'user_panel#index', :as => :user_panel
        get 'reports/index'
        get "/user_panel" => 'user_panel#index', as: :user_root
        get '/users_panel/statistics' =>'user_panel#statistics', :as => :statistics
        get '/users_panel/view_all' =>'user_panel#view_all', :as => :view_all
        get '/users_panel/report/select_report' => 'user_panel#select_type', :as => :report_mode
        post '/routes/transport_routes' => 'routes#transport_routes' , :as => :get_routes
        get '/security_news'  => 'security_news#index',  :as => :novelties
        get '/security_news/new'  => 'security_news#new', :as => :new_novelty
    end

    namespace :user do
        root "user_panel#index"
    end

    devise_scope :user do
        get 'auth/sign_in', to: 'devise/sessions#new'
        get 'auth/registration', to: 'devise/registrations#new'
        delete 'auth/sign_out', to: 'devise/sessions#destroy'
    end

    get "auth/login" => "users/sessions#new", as: "login"
    get "auth/registration" => "user/registrations#new", as: "register"

end
