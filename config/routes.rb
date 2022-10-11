Rails.application.routes.draw do
  post "inbound/sms" => "sms#inbound"
  post 'outbound/sms' => "sms#outbound"
  match "*path", :to => "application#routing_error", via: [:get, :delete, :patch, :put]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
