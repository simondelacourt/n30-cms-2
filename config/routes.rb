Simondelacourt::Application.routes.draw do
  

  root :to => 'blog#index'
  match 'feed' => 'home#feed', :as => 'feed'
  
  devise_for :users, { :sessions => "sessions" }
  
  resources :blog_posts, :controller => 'blog', :path => '/blog'
  resources :blog_categories, :path => '/categories'
  
  namespace :admin do
    root :to => 'main#index'
    resources :blog_posts do
       get :autocomplete_tag_name, :on => :collection
    end
    resources :blog_groups do
      resources :blog_categories
    end
    resources :pages do
      resources :embeddables
    end
    resources :users
    resources :menus do
      get 'saveorder', :on => :collection
    end
    
    resources :settings do
      collection do
        resources :templates
        resources :thumb_styles, :controller => :thumbnails, :path => 'thumbnails'
        resources :stylesheets
      end
    end
  end
end
