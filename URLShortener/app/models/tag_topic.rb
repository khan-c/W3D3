# == Schema Information
#
# Table name: tag_topics
#
#  id         :integer          not null, primary key
#  tag_topic  :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class TagTopic < ApplicationRecord
  validates :tag_topic, uniqueness: true, presence: true

  has_many :taggings,
    class_name: :Tagging,
    primary_key: :id,
    foreign_key: :tag_topic_id

  has_many :urls,
    through: :taggings,
    source: :url

  def popular_links
    data = Visit.joins("taggings ON taggings.shortened_url_id = visits.shortened_url_id")
      .select(:shortened_url_id)
      .group(:shortened_url_id)
      .limit(5)
      .where(tag_topic_id: @id)

    p data
  end

end
