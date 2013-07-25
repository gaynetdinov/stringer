require_relative "../models/feed"

class GroupRepository

  def self.list
    Group.order(:name)
  end

  def self.tree
    unread_count_by_groups = Feed.select("count(stories.id) as unread_count, groups.name as name").
      joins(:group).joins(:stories).
      where("stories.is_read = false").
      group("groups.name").inject({}){|res, row| res[row.name] = row.unread_count; res }

    unread_count_by_feeds = Feed.select("count(stories.id) as unread_count, feeds.name as name").
      joins(:stories).where("stories.is_read = false").group("feeds.name").
      inject({}){|res, row| res[row.name] = row.unread_count; res }

    unread_count_uncategorized = Feed.select("count(stories.id) as unread_count").
      joins(:stories).where("stories.is_read = false").
      where("not exists(select 1 from groups where groups.id = feeds.group_id)").first.unread_count

    Feed.joins("left outer join groups on feeds.group_id = groups.id").
      includes(:group).order("lower(groups.name), lower(feeds.name)").group_by{|row| row.group.try(:name)}.map do |group, feeds|
      if group
        { label: group, unread_count: unread_count_by_groups[group], url: "group=#{group}", 
          children: feeds.map{|feed| { label: feed.name, url: "feed=#{feed.name}", unread_count: unread_count_by_feeds[feed.name] }}}
      else
        { label: 'Uncategorized', unread_count: unread_count_uncategorized, url: "group=Uncategorized", 
          children: feeds.map{|feed| { label: feed.name, url: "feed=#{feed.name}", unread_count: unread_count_by_feeds[feed.name] }}}
      end

    end
  end

end

