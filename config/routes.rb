Rails.application.routes.draw do
  resources :projects

  get 'export_projects', to: 'projects#export_projects'
  get 'export_products', to: 'projects#export_products'
end
