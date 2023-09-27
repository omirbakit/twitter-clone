class TweetPresenter
  include ActionView::Helpers::DateHelper
  include Rails.application.routes.url_helpers

  def initialize(tweet:, current_user:, tweet_activity: nil)
    @tweet = tweet
    @current_user = current_user
    @tweet_activity = tweet_activity
  end

  delegate :id, :user, :body, :likes_count, :retweets_count, :views_count, :reply_tweets_count, to: :tweet
  delegate :display_name, :username, to: :user

  attr_reader :tweet, :current_user, :tweet_activity

  def tweet_activity_html
    case tweet_activity&.verb
    when "liked"
      "<p class=\"fw-bold fs-6 text-muted mb-0\" style=\"margin-left: 5rem; font-size: 13px !important;\">#{tweet_activity.actor.display_name} liked</p>"
    when "replied"
      "<p class=\"fw-bold fs-6 text-muted mb-0\" style=\"margin-left: 5rem; font-size: 13px !important;\">#{tweet_activity.actor.display_name} replied to</p>"
    when "retweeted"
      "<p class=\"fw-bold fs-6 text-muted mb-0\" style=\"margin-left: 5rem; font-size: 13px !important;\">#{tweet_activity.actor.display_name} retweeted</p>"
    else
      ""  
    end
  end

  def created_at
    if (Time.zone.now - tweet.created_at) > 1.day
      tweet.created_at.strftime("%b %-d")
    else
      time_ago_in_words(tweet.created_at)
    end
  end

  def body_html(p_class: "")
    texts = tweet.body.split(" ").map do |word|
      if word.include?("#") || word.include?("@")
        "<a class=\"twitter-link\">#{word}</a>"
      else
        word
      end
    end
    "<p class=\"#{p_class}\">#{texts.join(" ")}</p>"
  end

  def avatar
    return user.avatar if user.avatar.present?

    ActionController::Base.helpers.asset_path("user.png")
  end

  def like_tweet_url(source: "tweet_card")
    if tweet_liked_by_current_user?
      tweet_like_path(tweet, current_user.likes.find_by(tweet: tweet), source: source)
    else
      tweet_likes_path(tweet, source: source)
    end
  end

  def turbo_like_data_method
    if tweet_liked_by_current_user?
      "delete"
    else
      "post"
    end
  end

  def like_heart_image
    if tweet_liked_by_current_user?
      "heart-filled.png"
    else
      "heart-unfilled.png"
    end
  end

  def bookmark_tweet_url(source: "tweet_card")
    if tweet_bookmarked_by_current_user?
      tweet_bookmark_path(tweet, current_user.bookmarks.find_by(tweet: tweet), source: source)
    else
      tweet_bookmarks_path(tweet, source: source)
    end
  end

  def turbo_bookmark_data_method
    if tweet_bookmarked_by_current_user?
      "delete"
    else
      "post"
    end
  end

  def bookmark_image
    if tweet_bookmarked_by_current_user?
      "bookmark-filled.png"
    else
      "bookmark-unfilled.png"
    end
  end

  def bookmark_text
    if tweet_bookmarked_by_current_user?
      "Bookmarked"
    else
      "Bookmark"
    end
  end

  def retweet_tweet_url(source: "tweet_card")
    if tweet_retweeted_by_current_user?
      tweet_retweet_path(tweet, current_user.retweets.find_by(tweet: tweet), source: source)
    else
      tweet_retweets_path(tweet, source: source)
    end
  end

  def turbo_retweet_data_method
    if tweet_retweeted_by_current_user?
      "delete"
    else
      "post"
    end
  end

  def retweet_image
    if tweet_retweeted_by_current_user?
      "retweet-filled.png"
    else
      "retweet-unfilled.png"
    end
  end

  private

  def tweet_liked_by_current_user
    @tweet_liked_by_current_user ||= tweet.liked_users.include?(current_user)
  end
  alias_method :tweet_liked_by_current_user?, :tweet_liked_by_current_user

  def tweet_bookmarked_by_current_user
    @tweet_bookmarked_by_current_user ||= tweet.bookmarked_users.include?(current_user)
  end
  alias_method :tweet_bookmarked_by_current_user?, :tweet_bookmarked_by_current_user

  def tweet_retweeted_by_current_user
    @tweet_retweeted_by_current_user ||= tweet.retweeted_users.include?(current_user)
  end
  alias_method :tweet_retweeted_by_current_user?, :tweet_retweeted_by_current_user
end