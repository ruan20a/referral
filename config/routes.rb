# == Route Map
#
#                    Prefix Verb     URI Pattern                                           Controller#Action
#          new_view_session GET      /views/sign_in(.:format)                              devise/sessions#new
#              view_session POST     /views/sign_in(.:format)                              devise/sessions#create
#      destroy_view_session DELETE   /views/sign_out(.:format)                             devise/sessions#destroy
#             view_password POST     /views/password(.:format)                             devise/passwords#create
#         new_view_password GET      /views/password/new(.:format)                         devise/passwords#new
#        edit_view_password GET      /views/password/edit(.:format)                        devise/passwords#edit
#                           PATCH    /views/password(.:format)                             devise/passwords#update
#                           PUT      /views/password(.:format)                             devise/passwords#update
#  cancel_view_registration GET      /views/cancel(.:format)                               devise_invitable/registrations#cancel
#         view_registration POST     /views(.:format)                                      devise_invitable/registrations#create
#     new_view_registration GET      /views/sign_up(.:format)                              devise_invitable/registrations#new
#    edit_view_registration GET      /views/edit(.:format)                                 devise_invitable/registrations#edit
#                           PATCH    /views(.:format)                                      devise_invitable/registrations#update
#                           PUT      /views(.:format)                                      devise_invitable/registrations#update
#                           DELETE   /views(.:format)                                      devise_invitable/registrations#destroy
#         new_admin_session GET      /admins/sign_in(.:format)                             admins/sessions#new
#             admin_session POST     /admins/sign_in(.:format)                             admins/sessions#create
#     destroy_admin_session DELETE   /admins/sign_out(.:format)                            admins/sessions#destroy
#            admin_password POST     /admins/password(.:format)                            devise/passwords#create
#        new_admin_password GET      /admins/password/new(.:format)                        devise/passwords#new
#       edit_admin_password GET      /admins/password/edit(.:format)                       devise/passwords#edit
#                           PATCH    /admins/password(.:format)                            devise/passwords#update
#                           PUT      /admins/password(.:format)                            devise/passwords#update
# cancel_admin_registration GET      /admins/cancel(.:format)                              admins/registrations#cancel
#        admin_registration POST     /admins(.:format)                                     admins/registrations#create
#    new_admin_registration GET      /admins/sign_up(.:format)                             admins/registrations#new
#   edit_admin_registration GET      /admins/edit(.:format)                                admins/registrations#edit
#                           PATCH    /admins(.:format)                                     admins/registrations#update
#                           PUT      /admins(.:format)                                     admins/registrations#update
#                           DELETE   /admins(.:format)                                     admins/registrations#destroy
#   accept_admin_invitation GET      /admins/invitation/accept(.:format)                   devise/invitations#edit
#   remove_admin_invitation GET      /admins/invitation/remove(.:format)                   devise/invitations#destroy
#          admin_invitation POST     /admins/invitation(.:format)                          devise/invitations#create
#      new_admin_invitation GET      /admins/invitation/new(.:format)                      devise/invitations#new
#                           PATCH    /admins/invitation(.:format)                          devise/invitations#update
#                           PUT      /admins/invitation(.:format)                          devise/invitations#update
#          new_user_session GET      /users/sign_in(.:format)                              users/sessions#new
#              user_session POST     /users/sign_in(.:format)                              users/sessions#create
#      destroy_user_session DELETE   /users/sign_out(.:format)                             users/sessions#destroy
#   user_omniauth_authorize GET|POST /users/auth/:provider(.:format)                       omniauth_callbacks#passthru {:provider=>/linkedin/}
#    user_omniauth_callback GET|POST /users/auth/:action/callback(.:format)                omniauth_callbacks#(?-mix:linkedin)
#             user_password POST     /users/password(.:format)                             devise/passwords#create
#         new_user_password GET      /users/password/new(.:format)                         devise/passwords#new
#        edit_user_password GET      /users/password/edit(.:format)                        devise/passwords#edit
#                           PATCH    /users/password(.:format)                             devise/passwords#update
#                           PUT      /users/password(.:format)                             devise/passwords#update
#  cancel_user_registration GET      /users/cancel(.:format)                               devise_invitable/registrations#cancel
#         user_registration POST     /users(.:format)                                      devise_invitable/registrations#create
#     new_user_registration GET      /users/sign_up(.:format)                              devise_invitable/registrations#new
#    edit_user_registration GET      /users/edit(.:format)                                 devise_invitable/registrations#edit
#                           PATCH    /users(.:format)                                      devise_invitable/registrations#update
#                           PUT      /users(.:format)                                      devise_invitable/registrations#update
#                           DELETE   /users(.:format)                                      devise_invitable/registrations#destroy
#    accept_user_invitation GET      /users/invitation/accept(.:format)                    devise/invitations#edit
#    remove_user_invitation GET      /users/invitation/remove(.:format)                    devise/invitations#destroy
#           user_invitation POST     /users/invitation(.:format)                           devise/invitations#create
#       new_user_invitation GET      /users/invitation/new(.:format)                       devise/invitations#new
#                           PATCH    /users/invitation(.:format)                           devise/invitations#update
#                           PUT      /users/invitation(.:format)                           devise/invitations#update
#                     users GET      /users(.:format)                                      users#index
#                           POST     /users(.:format)                                      users#create
#                  new_user GET      /users/new(.:format)                                  users#new
#                 edit_user GET      /users/:id/edit(.:format)                             users#edit
#                      user GET      /users/:id(.:format)                                  users#show
#                           PATCH    /users/:id(.:format)                                  users#update
#                           PUT      /users/:id(.:format)                                  users#update
#                           DELETE   /users/:id(.:format)                                  users#destroy
#                    admins GET      /admins(.:format)                                     admins#index
#                           POST     /admins(.:format)                                     admins#create
#                 new_admin GET      /admins/new(.:format)                                 admins#new
#                edit_admin GET      /admins/:id/edit(.:format)                            admins#edit
#                     admin GET      /admins/:id(.:format)                                 admins#show
#                           PATCH    /admins/:id(.:format)                                 admins#update
#                           PUT      /admins/:id(.:format)                                 admins#update
#                           DELETE   /admins/:id(.:format)                                 admins#destroy
#              private_jobs GET      /jobs/private(.:format)                               jobs#private
#                      jobs GET      /jobs(.:format)                                       jobs#index
#                           POST     /jobs(.:format)                                       jobs#create
#                   new_job GET      /jobs/new(.:format)                                   jobs#new
#                  edit_job GET      /jobs/:id/edit(.:format)                              jobs#edit
#                       job GET      /jobs/:id(.:format)                                   jobs#show
#                           PATCH    /jobs/:id(.:format)                                   jobs#update
#                           PUT      /jobs/:id(.:format)                                   jobs#update
#                           DELETE   /jobs/:id(.:format)                                   jobs#destroy
#               invitations GET      /invitations(.:format)                                invitations#index
#                           POST     /invitations(.:format)                                invitations#create
#            new_invitation GET      /invitations/new(.:format)                            invitations#new
#           edit_invitation GET      /invitations/:id/edit(.:format)                       invitations#edit
#                invitation GET      /invitations/:id(.:format)                            invitations#show
#                           PATCH    /invitations/:id(.:format)                            invitations#update
#                           PUT      /invitations/:id(.:format)                            invitations#update
#                           DELETE   /invitations/:id(.:format)                            invitations#destroy
#                 referrals GET      /referrals(.:format)                                  referrals#index
#                           POST     /referrals(.:format)                                  referrals#create
#              new_referral GET      /referrals/new(.:format)                              referrals#new
#             edit_referral GET      /referrals/:id/edit(.:format)                         referrals#edit
#                  referral GET      /referrals/:id(.:format)                              referrals#show
#                           PATCH    /referrals/:id(.:format)                              referrals#update
#                           PUT      /referrals/:id(.:format)                              referrals#update
#                           DELETE   /referrals/:id(.:format)                              referrals#destroy
#                whitelists GET      /whitelists(.:format)                                 whitelists#index
#                           POST     /whitelists(.:format)                                 whitelists#create
#             new_whitelist GET      /whitelists/new(.:format)                             whitelists#new
#            edit_whitelist GET      /whitelists/:id/edit(.:format)                        whitelists#edit
#                 whitelist GET      /whitelists/:id(.:format)                             whitelists#show
#                           PATCH    /whitelists/:id(.:format)                             whitelists#update
#                           PUT      /whitelists/:id(.:format)                             whitelists#update
#                           DELETE   /whitelists/:id(.:format)                             whitelists#destroy
#        enterprise_company GET      /companies/:id/enterprise(.:format)                   companies#enterprise
#       private_invitations GET      /companies/:id/private_invitations(.:format)          private_invitations#index
#                           POST     /companies/:id/private_invitations(.:format)          private_invitations#create
#    new_private_invitation GET      /companies/:id/private_invitations/new(.:format)      private_invitations#new
#   edit_private_invitation GET      /companies/:id/private_invitations/:id/edit(.:format) private_invitations#edit
#        private_invitation GET      /companies/:id/private_invitations/:id(.:format)      private_invitations#show
#                           PATCH    /companies/:id/private_invitations/:id(.:format)      private_invitations#update
#                           PUT      /companies/:id/private_invitations/:id(.:format)      private_invitations#update
#                           DELETE   /companies/:id/private_invitations/:id(.:format)      private_invitations#destroy
#                 companies GET      /companies(.:format)                                  companies#index
#                           POST     /companies(.:format)                                  companies#create
#               new_company GET      /companies/new(.:format)                              companies#new
#              edit_company GET      /companies/:id/edit(.:format)                         companies#edit
#                   company GET      /companies/:id(.:format)                              companies#show
#                           PATCH    /companies/:id(.:format)                              companies#update
#                           PUT      /companies/:id(.:format)                              companies#update
#                           DELETE   /companies/:id(.:format)                              companies#destroy
#                  accesses GET      /accesses(.:format)                                   accesses#index
#                           POST     /accesses(.:format)                                   accesses#create
#                new_access GET      /accesses/new(.:format)                               accesses#new
#               edit_access GET      /accesses/:id/edit(.:format)                          accesses#edit
#                    access GET      /accesses/:id(.:format)                               accesses#show
#                           PATCH    /accesses/:id(.:format)                               accesses#update
#                           PUT      /accesses/:id(.:format)                               accesses#update
#                           DELETE   /accesses/:id(.:format)                               accesses#destroy
#                      root GET      /                                                     home#index
#                           GET      /enterprise/:access_token(.:format)                   home#enterprise
#              send_request POST     /send_request(.:format)                               home#send_request
#      send_company_request POST     /send_company_request(.:format)                       home#send_company_request
#

Wekrut::Application.routes.draw do
  devise_for :views
  devise_for :admins, controllers: { registrations: "admins/registrations", sessions: "admins/sessions"}
  devise_for :users, controllers: {omniauth_callbacks: "omniauth_callbacks", sessions: "users/sessions" }
  resources :users
  resources :admins
  resources :jobs do
    collection do
      get 'private'
    end
  end

  resources :invitations
  #resources :user_profiles

  resources :referrals
  resources :whitelists

  resources :companies do
    member do
      get 'enterprise'
      resources :private_invitations
    end

  end
  resources :accesses


  root "home#index"
  match '/enterprise/:access_token', to: 'home#enterprise', via: 'get'
  #beta request only on post
  match '/send_request', to: 'home#send_request', via: 'post'
  match '/send_company_request', to: 'home#send_company_request', via: 'post'
  # match '/companies/:id/enterprise', to: 'companies#enterprise', via: 'get'



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
end
