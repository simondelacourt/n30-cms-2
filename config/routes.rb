Simondelacourt::Application.routes.draw do
  root :to => 'home#index'
  get 'feed' => 'home#feed', :as => 'feed'
  get 'as/css/:id' => 'templatemanager#css', :as => 'cssfile'
  get 'as/javascript/:id' => 'templatemanager#js', :as => 'jsfile'
  
  get 'as/plugin_:id/:page.:format' => 'templatemanager#plugin', :as => 'side_pageplugin'
  
  get 'search' => 'blog#search', :as => 'search'
  resources :pages
  
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
    resources :blog_templates
    resources :pages do
      resources :embeddables
    end
    resources :users
    resources :menus do
      get 'saveorder', :on => :collection
    end
    resources :page_plugins do
      get 'export'
      post 'import', :on => :collection
    end
    resources :extras do
      post 'importtumblr', :on => :collection
    end
    resources :settings do
      get :resetsettings, :on => :collection
      get :setashome, :on => :collection
      collection do
        resources :templates do
          get 'savecssorder'
          get 'savejsorder'
        end
        resources :thumb_styles, :controller => :thumbnails, :path => 'thumbnails'
        resources :stylesheets
        resources :javascripts
      end
    end
  end
end
