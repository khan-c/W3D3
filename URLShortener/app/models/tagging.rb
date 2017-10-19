# == Schema Information
#
# Table name: taggings
#
#  id               :integer          not null, primary key
#  tag_topic_id     :integer          not null
#  shortened_url_id :integer          not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class Tagging < ApplicationRecord
  validates_uniqueness_of :shortened_url_id, scope: :tag_topic_id

  belongs_to :topic,
    class_name: :TagTopic,
    primary_key: :id,
    foreign_key: :tag_topic_id

  belongs_to :url,
    class_name: :ShortenedUrl,
    primary_key: :id,
    foreign_key: :shortened_url_id

end
