class AddActorToTweetActivities < ActiveRecord::Migration[7.0]
  def change
    add_reference :tweet_activities, :actor, null: false, foreign_key: { to_table: :users }
  end
end
