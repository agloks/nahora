#TODO find methor use SELECT *, perfomance from this method not is good than SELECT FIELD, adjust more later when is possile.
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
      orderQuery = NamedTuple(username: String).from(user_params.validate!)
      user = User.query.find!(orderQuery)
      p user
      respond_with 200 do
        json user.to_json
      end
    rescue exception
      p exception
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
    #REF UPDATE: https://github.com/anykeyh/clear/blob/master/spec/model/model_spec.cr
    begin
      queryUpdate = user_params_update.validate!.reject "phone"
      User.query.where(
        {phone: params["phone"]}
        ).to_update.set(queryUpdate).execute
      user = User.query.find!({phone: params["phone"]})

      respond_with 201 do
        json user.to_json
      end
    rescue exception
      p exception
      respond_with 422 do
        json BAD_REQUEST
      end
    end
  end

  def destroy
    #TIP more safely and robust way to do it: https://github.com/anykeyh/clear/blob/master/spec/sql/delete_spec.cr
    # user = User.query.where(
    #   {id: user_params_delete.validate!["id"]}
    #   ).to_delete.execute
    userParamID = user_params_delete.validate!["id"]
    begin
      user = User.query.select("id").find!({id: userParamID})
      user.delete
      deleted = {message: "#{user_params_delete.validate!["id"]} erased with sucesfull!"}
      
      #TODO: put code 204 to send no-content
      respond_with 200 do
        json deleted.to_json
     end  
    rescue exception
      p exception
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

  def user_params_delete
    params.validation do
      required :id
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

  def user_params_update
    params.validation do
      required :phone
      optional :username
      optional :money
      optional :gender
    end
  end
end
