class UserController < ApplicationController
  def index
    users = User.all
    respond_with 200 do
      json users.to_json
    end
  end

  def show
    if user = User.find params["id"]
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
    user = User.new(user_params.validate!)

    if user.valid? && user.save
      respond_with 201 do
        json user.to_json
      end
    else
      results = {status: "invalid"}
      respond_with 422 do
        json results.to_json
      end
    end
  end

  def update
    if user = User.find(params["id"])
      user.set_attributes(user_params.validate!)
      if user.valid? && user.save
        respond_with 200 do
          json user.to_json
        end
      else
        results = {status: "invalid"}
        respond_with 422 do
          json results.to_json
        end
      end
    else
      results = {status: "not found"}
      respond_with 404 do
        json results.to_json
      end
    end
  end

  def destroy
    if user = User.find params["id"]
      user.destroy
      respond_with 204 do
        json ""
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
