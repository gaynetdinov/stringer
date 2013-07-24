require_relative "../../models/feed"
require_relative "../../utils/opml_parser"

class ImportFromOpml
  ONE_DAY = 24 * 60 * 60

  def self.import(opml_contents)
    feeds_with_groups = OpmlParser.new.parse_feeds(opml_contents)

    # First save feeds without groups.
    feeds_with_groups.delete('wo_group').each do |feed|
      Feed.create(name: feed[:name],
                  url: feed[:url],
                  last_fetched: Time.now - ONE_DAY)
    end

    # Then create feeds with groups. The method consider situation
    # when feeds are already imported without groups, so it's possible
    # to re-import the same feeds just to set group_id for feeds.
    feeds_with_groups.each do |group_name, feeds|
      group = Group.where(name: group_name).first_or_create
      feeds.each do |feed|
        feed = Feed.where(name: feed[:name], url: feed[:url]).first_or_initialize
        if feed.new_record?
          feed.last_fetched = Time.now - ONE_DAY
        end
        feed.group_id = group.id
        feed.save
      end
    end
  end
end
