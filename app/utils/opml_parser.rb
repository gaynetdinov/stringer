require "nokogiri"

class OpmlParser
  def parse_feeds(contents)
    doc = Nokogiri.XML(contents)
    feeds_with_groups = { 'wo_group' => [] }

    doc.xpath("//body/outline").each do |outline|

      if outline.attributes["xmlUrl"].to_s.empty? # it's a group!
        group_name = outline.attributes["title"].value
        feeds_with_groups[group_name] ||= []
        outline.xpath('./outline').each do |feed_row|
          feeds_with_groups[group_name] << { name: feed_row.attributes["title"].value,
                                             url: feed_row.attributes["xmlUrl"].value }
        end
      else # it'a feed without group
        feeds_with_groups['wo_group'] << { name: outline.attributes["title"].value,
                                           url: outline.attributes["xmlUrl"].value }
      end
    end
    feeds_with_groups
  end
end
