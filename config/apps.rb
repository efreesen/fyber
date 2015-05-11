Padrino.configure_apps do
  # enable :sessions
  set :session_secret, 'ebef76d2c6c9b769271755a9314ba083e0bf4b72142688b5d73ee3e9ed3ae964'
  set :protection, :except => :path_traversal
end

# Mounts the core application for this project
Padrino.mount('Fyber::App', :app_file => Padrino.root('app/app.rb')).to('/')
