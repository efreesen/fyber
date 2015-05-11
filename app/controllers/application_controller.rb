Fyber::App.controller do
  get '/' do
    erb :index
  end

  post '/' do
    params.to_s
  end
end