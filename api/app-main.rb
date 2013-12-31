class Miner
  def initialize
    @oauth = Koala::Facebook::OAuth.new($config.app_api_key,$config.app_secret,$config.domain)
    @graph = Koala::Facebook::API.new(@oauth.get_app_access_token)
    @keywords = $config.keywords
    @duration = last_month
    @page_id = $config.page_id
    @post_fields = $config.post_fields
    @posts = []
  end

  def get_likes
    @graph.get_connections(@page_id,"likes?fields=id").map{ |like| like["id"] }
  end

  def get_posts(page_id, since)
    @graph.get_connections(page_id,"posts?fields=#{@post_fields.join(",")}&since=#{since}")
  end

  def mine
    success do
      get_likes.each do |like_id|
        search_keywords get_posts(like_id, @duration)
      end
    end
  end

  def search_keywords(page_posts)
    @keywords.each do |keyword|
      page_posts.each do |post|
        if post["message"].to_s.downcase.index(keyword) != nil || post["name"].to_s.downcase.index(keyword) !=nil
          @posts << post
        end
      end
    end
  end

  def data
    @posts
  end

private
  #these are helpers, best to move them in a module

  def success &block
    begin
      block.call
      true
    rescue
      false
    end
  end

  def last_month
    d = DateTime.now << 1
    "#{d.year}-#{d.month}-#{d.day}"
  end

end
