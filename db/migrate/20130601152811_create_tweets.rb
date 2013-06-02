class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.string :reference
      t.string :content
      t.datetime :posted_at
      t.integer :user_id
      t.boolean :sent, default: false

      t.timestamps
    end
  end
end
