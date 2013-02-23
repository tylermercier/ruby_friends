class MyApp < Sinatra::Base
  get "/sentiment" do
    @sentiment = Sentimentalizer.analyze('This is a statement')
    content_type :json
    @sentiment.to_json
  end
end
