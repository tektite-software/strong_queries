class PostsController < ApplicationController
  before_action :set_post, except: [:index]
  def index
    @posts = Post.all
    render @posts
  end

  def show
    render @post
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end
end
