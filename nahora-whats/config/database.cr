#CLEARCHANGE: https://clear.gitbook.io/project/introduction/installation
require "clear"

# initialize a pool of database connection:
Clear::SQL.init(ENV["DATABASE_URL"]? || Amber.settings.database_url, 
    connection_pool_size: 5)