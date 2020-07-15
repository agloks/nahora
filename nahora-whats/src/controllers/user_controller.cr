class UserController < ApplicationController
  NOT_FOUND = {status: "not found"}.to_h
  BAD_REQUEST = {status: "bad request"}.to_h

  def index
    #TODO: pagination
    users = User.query.order_by("id").limit(10).map(&.to_h)
    respond_with 200 do
      json users.to_json
    end
  end

  def show
    begin
      user = User.query.find!( {username: params["username"]} )    
      respond_with 200 do
        json user.to_json
      end
    rescue exception
      respond_with 422 do
        json BAD_REQUEST
      end      
    end
  end

  def create
    begin
      user = User.new(user_params_create.validate!)
      user.save!
      respond_with 201 do
        json user.to_json
      end
    rescue exception
      #TODO: Take the msg exception, and handle individual case appropriately. i.e: duplicate key error, invalid field in enum, etc.
      respond_with 422 do
        json BAD_REQUEST
      end      
    end
  end

  def update
    # if user = User.query.where({username: params["username"]})
    # if user = User.find(params["id"])
      # user.set_attributes(user_params.validate!)
      if true
        respond_with 200 do
          json NOT_FOUND
        end
      else
        respond_with 422 do
          json NOT_FOUND
        end
      end
    # else
    #   NOT_FOUND = {status: "not found"}
    #   respond_with 404 do
    #     json NOT_FOUND.to_json
    #   end
    # end
  end

  def destroy
    if true
      # user.destroy
      respond_with 204 do
         json NOT_FOUND
      end
    else
      respond_with 404 do
        json NOT_FOUND
      end
    end
  end

  def user_params
    params.validation do
      required :username
    end
  end

  def user_params_create
    params.validation do
      required :username
      required :phone
      optional :money
      optional :gender
    end
  end
end
