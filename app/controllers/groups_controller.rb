require_relative "../repositories/feed_repository"
require_relative "../models/group"

class Stringer < Sinatra::Base

  get "/groups", :provides => [:html, :json] do
    respond_to do |f|
      f.on('text/html') do
        @groups = GroupRepository.list
        erb :'groups/index'
      end
      f.on('application/json') do
        GroupRepository.tree.to_json
      end
    end
  end

  get "/groups/new" do
    erb :'groups/add'
  end

  post "/groups" do
    #@feed_url = params[:feed_url]
    #feed = AddNewFeed.add(@feed_url)

    #if feed and feed.valid?
    #  FetchFeeds.enqueue([feed])

    #  flash[:success] = t('feeds.add.flash.added_successfully')
    #  redirect to("/")
    #elsif feed
    #  flash.now[:error] = t('feeds.add.flash.already_subscribed_error')
    #  erb :'feeds/add'
    #else
    #  flash.now[:error] = t('feeds.add.flash.feed_not_found_error')
    #  erb :'feeds/add'
    #end
  end

end
