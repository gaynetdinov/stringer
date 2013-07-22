require_relative "../models/feed"

class GroupRepository

  def self.list
    Feed.joins(:group).includes(:group).order("lower(groups.name), lower(feeds.name)").group_by{|row| row.group.name}.map do |group, feeds|
      { label: group, children: feeds.map{|feed| { label: feed.name }}}
    end
  end

end

