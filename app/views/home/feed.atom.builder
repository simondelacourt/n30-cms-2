atom_feed :language => 'en-US' do |feed|
  feed.title @title
  feed.updated @updated
  feed.link root_url, :href => root_url

  @blogposts.each do |item|
    next if item.updated_at.blank?

    feed.entry( item ) do |entry|
      entry.title item.title
      entry.summary item.body
      entry.link blog_post_url(item), :href => blog_post_url(item)

      # the strftime is needed to work with Google Reader.
      #entry.updated(item.updated_at.strftime("%Y-%m-%dT%H:%M:%SZ")) 

      entry.author do |author|
        author.name item.user.firstname + " " + item.user.familyname
      end
    end
  end
end
