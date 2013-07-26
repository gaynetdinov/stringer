require_relative "../../models/feed"
require_relative "../../models/group"
require_relative "../../utils/opml_parser"

class ImportFromOpml
  ONE_DAY = 24 * 60 * 60

  def self.import(opml_contents)
    feeds_with_groups = OpmlParser.new.parse_feeds(opml_contents)

    # It considers a situation when feeds are already imported without groups,
    # so it's possible to re-import the same subscriptions.xml just to set group_id
    # for existing feeds.
    feeds_with_groups.each do |group_name, feeds|
      if feeds.size > 0
        group = Group.where(name: group_name).first_or_create
        feeds.each do |feed|
          feed = Feed.where(name: feed[:name], url: feed[:url]).first_or_initialize
          feed.group_id = group.id
          if feed.new_record?
            feed.last_fetched = Time.now - ONE_DAY
          end
          feed.save
        end
      end
    end
  end
end
