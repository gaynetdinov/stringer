require_relative "../../models/feed"
require_relative "../../utils/opml_parser"

class ImportFromOpml
  ONE_DAY = 24 * 60 * 60

  def self.import(opml_contents)
    feeds_with_groups = OpmlParser.new.parse_feeds(opml_contents)

    feeds_with_groups.delete('wo_group').each do |feed|
      Feed.create(name: feed[:name],
                  url: feed[:url],
                  last_fetched: Time.now - ONE_DAY)
    end

    feeds_with_groups.each do |group_name, feeds|
      group = Group.where(name: group_name).first_or_create
      feeds.each do |feed|
        Feed.create(name: feed[:name],
                    group_id: group.id,
                    url: feed[:url],
                    last_fetched: Time.now - ONE_DAY)
      end
    end
  end
end
