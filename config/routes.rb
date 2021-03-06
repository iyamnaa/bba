Rails.application.routes.draw do
  resources :payments do
    collection do
      post :receive_webhook
    end
  end
  resources :campaign_complaints
  resources :doas
  resources :campaigns
  resources :products
  resources :suppliers
  resources :donations

  #User
  get 'users/profil/:name', to: 'users#index', as: 'users_index'
  get 'getting-started', to: 'users#getting_started', as: 'getting_started'

  #Devise
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks',
                                    registrations: 'users/registrations',
                                    confirmations: 'users/confirmations',
                                    sessions: 'users/sessions',
                                    passwords: 'users/passwords' }

  #Rails Admin
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  #CKEditor
  mount Ckeditor::Engine => '/ckeditor'

  #Root
  root to: "home#index"

  #Campaign
  post 'campaigns/approval/:id', to: 'campaigns#approval', as: 'approve_campaign'
  post 'campaigns/decline/:id', to: 'campaigns#decline', as: 'decline_campaign'
  post 'campaigns/save-donation/:id', to: 'campaigns#save_donation', as: 'save_donation'
  post 'campaigns/:id', to: 'campaigns#donate', as: 'campaign_donate'

  match "notification/handle" => "campaigns#receive_webhook", via: [:post]

  #Campaign Complaint
  get 'campaign_complaints/campaign/:id', to: "campaign_complaints#show_all", as: 'show_all_complaints'

  #Doa
  get '/doas/change-status/:id', to: "doas#change_status", as: 'change_status'

  #MONTHLY REPORT
  get 'monthly_product_report/:month', to: "report_products#monthly", as: 'month_product'
  get 'monthly_product_report_export/:month', to: "report_products#export", as: 'month_product_export'
  get 'monthly_donation_report/:month', to: "report_donation#monthly", as: 'month_donation'
  get 'monthly_donation_report_export/:month', to: "report_donation#export", as: 'month_donation_export'

  #NEWSLETTER
  get 'newsletters', to: 'newsletters#index'
  post 'newsletters/create', to: 'newsletters#create'

  #Cek Resi
  get 'cek_resi', to: 'home#cek_resi'

  #Donation
  get 'donation/cek', to: 'donations#cek', as: 'donation_cek'
  get 'campaigns/refund-donation/:order_id', to: 'campaigns#refund', as: 'refund_donation'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
