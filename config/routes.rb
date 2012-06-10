DjMonDemo::Application.routes.draw do

  mount DjMon::Engine => 'dj_mon', as: :dj_mon
  root :to => 'welcome#index'

end
