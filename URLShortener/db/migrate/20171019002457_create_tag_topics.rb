class CreateTagTopics < ActiveRecord::Migration[5.1]
  def change
    create_table :tag_topics do |t|
      t.string :tag_topic, null: false, unique: true

      t.timestamps
    end
  end
end
