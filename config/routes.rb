Rails.application.routes.draw do
  resources :projects
  resources :products

  root 'projects#index'

  get 'export_projects', to: 'projects#export_projects'
  get 'export_products', to: 'projects#export_products'
  get 'import_product_list', to: 'products#import_products'
  get 'import_projects', to: 'projects#import'
  post 'project_import', to: 'projects#project_import'

end
