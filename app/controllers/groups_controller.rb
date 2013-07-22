require_relative "../repositories/feed_repository"
require_relative "../models/group"

class Stringer < Sinatra::Base
  get "/groups", :provides => [:json] do
    respond_to do |f|
      f.on('application/json') do
        GroupRepository.list.to_json
      end
    end
  end
end
