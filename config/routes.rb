resources :projects do
  get 'status_analytics', :to => 'status_analytics#index'
end
