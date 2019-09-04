class HomeController < ApplicationController
  def index
    @posts = RecentPosts.list
  end

  def create
    Publisher.publish("posts",  {data: Time.current})

    head :no_content
  end
end
