require './app/domains/integration/offer_api_adapter'

Fyber::App.controller do
  get '/' do
    erb :index
  end

  post '/' do
    uid = params[:uid]
    pub0 = params[:pub0]
    page = params[:page].to_i

    @result = Fyber::Integration::OfferAPIAdapter.request(uid, pub0, page)

    if @result.is_a? Array
      erb :list_offers
    else
      @result
    end
  end
end