require "../config/application"

# This file is for setting up your seeds.
#
# To run seeds execute `amber db seed`

# Example:
if !User.where(username: "fakeAdmin").exists?
  User.create(username: "fakeAdmin", age: 12, phone: "4002-8002")
end