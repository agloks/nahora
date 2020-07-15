Amber::Server.configure do
  pipeline :api do
    # plug Amber::Pipe::PoweredByAmber.new
    plug Amber::Pipe::Error.new
    plug Amber::Pipe::Logger.new
    plug Amber::Pipe::Session.new
    # plug Amber::Pipe::CORS.new
  end

  routes :api do
    resources "/users", UserController, except: [:new, :edit, :show, :update]
    get "/users/:username", UserController, :show
    patch "/users/:phone", UserController, :update
  end
end
