class TweetsController < ApplicationController
  before_action :set_tweet, only: [:edit, :show, :destroy, :update]
  before_action :move_to_index, except: [:index, :show, :search]

  def index
    @tweets = Tweet.includes(:user).order("created_at DESC")
  end

  def new
    @tweet = Tweet.new
  end

  def create
    # binding.pry を行い、tweet_pramsを実行するとpermit内でtextが欠損していることが判明。
    Tweet.create(tweet_params)
  end

  def destroy
    @tweet.destroy
  end

  def edit
  end

  def update
    @tweet.update(tweet_params)
  end

  def show
    @comment = Comment.new
    @comments = @tweet.comment.includes(:user)
  end

  def search
    @tweets = Tweet.search(params[:keyword])
  end

  private
  def tweet_params
    # testからtextへ変更
    params.require(:tweet).permit(:image, :text).merge(user_id: current_user.id)
  end

  def set_tweet
    @tweet = Tweet.find(params[:id])
  end

  def move_to_index
    redirect_to action: :index unless user_signed_in?
  end
end