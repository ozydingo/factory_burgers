class PostsController < ApplicationController
  def show
    post = Post.find(params[:id])
    render json: post.to_json
  end
end
