#index
get '/users' do

end

#new
get '/users/new' do
  # @user = User.new
  erb :"/users/register"
end

#create
post '/users' do
  @user = User.new(params[:user])

  if @user.valid?
    @user.save
    redirect '/'
  else
    @errors = @user.errors.full_messages
    erb :"/users/register"
  end
end

#show
get '/users/:id' do
  @user = User.find_by(id: params[:id])
  erb :"/users/show"
end

#edit
get '/users/:id/edit' do

end

#update
patch '/users/:id' do

end

#delete
delete '/users/:id' do

end

get '/login' do
  erb :"/users/login"
end

post '/login' do
  @user = User.authenticate(params[:email], params[:password])
  if @user
    session[:user_id] = @user.id
    redirect "/"
  else
    @error = "Email and Password do not match."
    erb :"/users/login"
  end
end

delete '/logout' do
  session[:user_id] = nil
  redirect '/'
end
