Rails.application.routes.draw do
  get 'home/index'
  root to: 'home#index'

  get   '/mess/:mess'      =>  'home#create',       as:     :mess
  get   '/kafka/:mess'      =>  'home#kafka_receive',       as:     :kafka_receive
  get   '/rabbit/:mess'      =>  'home#rabbit_receive',       as:     :rabbit_receive
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
