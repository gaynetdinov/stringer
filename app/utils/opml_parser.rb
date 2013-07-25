require "nokogiri"

class OpmlParser
  def parse_feeds(contents)
    doc = Nokogiri.XML(contents)
    feeds_with_groups = {}

    doc.xpath("//body/outline").each do |outline|

      if outline.attributes["xmlUrl"].nil? # it's a group!
        group_name = outline.attributes["title"].try(:value) || outline.attributes["text"].try(:value)
        feeds = outline.xpath('./outline')
      else # it's a top-level feed, which means it's a feed without group
        group_name = 'Ungrouped'
        feeds = [outline]
      end
      feeds_with_groups[group_name] ||= []
      feeds.each do |feed|
        feeds_with_groups[group_name] << { name: feed.attributes["title"].value,
                                           url: feed.attributes["xmlUrl"].value }
      end
    end
    feeds_with_groups
  end
end
