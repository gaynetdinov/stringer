require_relative "../models/feed"

class GroupRepository

  def self.list

    unread_count = Feed.select("count(stories.id) as unread_count, groups.name as name").
      joins(:group).joins(:stories).
      where("stories.is_read = false").
      group("groups.name").inject({}){|res, row| res[row.name] = row.unread_count; res }

    unread_count_wo_group = Feed.select("count(stories.id) as unread_count, feeds.name").
      joins(:stories).where("stories.is_read = false").group("feeds.name").
      inject({}){|res, row| res[row.name] = row.unread_count; res }

    feeds = Feed.joins("left outer join groups on feeds.group_id = groups.id").
      includes(:group).order("lower(groups.name), lower(feeds.name)")

    feeds_w_group, feeds_wo_group = feeds.partition{|feed| feed.group }

    result = feeds_w_group.group_by{|row| row.group.name }.map do |group, feeds|
      { label: group, unread_count: unread_count[group], url: "group=#{group}", children: feeds.map{|feed| { label: feed.name }}}
    end
    result += feeds_wo_group.map{|f| { label: f.name, unread_count: unread_count_wo_group[f.name], url: "feed=#{f.name}" } }
  end

end

