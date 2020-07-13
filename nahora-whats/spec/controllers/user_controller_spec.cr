# require "./spec_helper"

# def user_hash
#   {} of String => String
# end

# def user_params
#   params = [] of String
#   params.join("&")
# end

# def create_user
#   model = User.new(user_hash)
#   model.save
#   model
# end

# class UserControllerTest < GarnetSpec::Controller::Test
#   getter handler : Amber::Pipe::Pipeline

#   def initialize
#     @handler = Amber::Pipe::Pipeline.new
#     @handler.build :api do
#       plug Amber::Pipe::Error.new
#       plug Amber::Pipe::Session.new
#     end
#     @handler.prepare_pipelines
#   end
# end

# describe UserControllerTest do
#   subject = UserControllerTest.new

#   it "renders user index json" do
#     User.clear
#     model = create_user
#     response = subject.get "/users"

#     response.status_code.should eq(200)
#   end

#   it "renders user show json" do
#     User.clear
#     model = create_user
#     location = "/users/#{model.id}"

#     response = subject.get location

#     response.status_code.should eq(200)
#   end

#   it "creates a user" do
#     User.clear
#     response = subject.post "/users", body: user_params

#     response.status_code.should eq(201)
#   end

#   it "updates a user" do
#     User.clear
#     model = create_user
#     response = subject.patch "/users/#{model.id}", body: user_params

#     response.status_code.should eq(200)
#   end

#   it "deletes a user" do
#     User.clear
#     model = create_user
#     response = subject.delete "/users/#{model.id}"

#     response.status_code.should eq(204)
#   end
# end
