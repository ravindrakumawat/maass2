class TweetsWorker

  include Rails.application.routes.url_helpers

  def initialize
    @@twitter = Twitter::Client.new
  end

  def send_blog_tweets(blog)    
    blog = Blog.find(blog)
    msg = "New Blog " + (blog.title).truncate(115)
    TweetsWorker.delay.twitter_post(@@twitter, msg)
  end
  
  def self.twitter_post(twitter, message)
    twitter.update(message)
  end
  
end