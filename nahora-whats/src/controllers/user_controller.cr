class UserController < ApplicationController
  @a = {status: "not found"}

  def index
    users = User.query.order_by("id").limit(10).map(&.to_h)
    respond_with 200 do
      json users.to_json
    end
  end

  def show
    #TODO: try catch here
    # user_params.validate!
    user = User.query.find!( {username: params["username"]} )
    # p user.to_h
    if true
      respond_with 200 do
        json user.to_json
      end
    else
      results = {status: "not found"}
      respond_with 404 do
        json results.to_json
      end
    end
  end

  def create
    # user = User.new(user_params.validate!)
    if true
      respond_with 201 do
        json @a.to_json
      end
    else
      results = {status: "invalid"}
      respond_with 422 do
        json results.to_json
      end
    end
  end

  def update
    # if user = User.query.where({username: params["username"]})
    # if user = User.find(params["id"])
      # user.set_attributes(user_params.validate!)
      if true
        respond_with 200 do
          json @a.to_json
        end
      else
        results = {status: "invalid"}
        respond_with 422 do
          json results.to_json
        end
      end
    # else
    #   results = {status: "not found"}
    #   respond_with 404 do
    #     json results.to_json
    #   end
    # end
  end

  def destroy
    if true
      # user.destroy
      respond_with 204 do
         json @a.to_json
      end
    else
      results = {status: "not found"}
      respond_with 404 do
        json results.to_json
      end
    end
  end

  def user_params
    p "into user_params"
    p params.to_unsafe_h
    params.validation do
      required :username
    end
  end
end
