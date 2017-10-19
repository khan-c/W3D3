# == Schema Information
#
#
# Table name: shortened_urls
#  id         :integer          not null, primary key
#  long_url   :string           not null
#  short_url  :string           not null
#  user_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#


class ShortenedUrl < ApplicationRecord
  include SecureRandom
  validates :long_url, :short_url, presence: true, uniqueness: true

  def self.random_code
    shortened_code = SecureRandom.urlsafe_base64[0..15]
    while ShortenedUrl.exists?(short_url: shortened_code)
      shortened_code = SecureRandom.urlsafe_base64[0..15]
    end
    shortened_code
  end

  def self.create!(user, long_url)
    short_url = ShortenedUrl.random_code
    ShortenedUrl.create(user_id: user.id, long_url: long_url, short_url: short_url)
    short_url
  end

  belongs_to :submitter,
    class_name: :User,
    primary_key: :id,
    foreign_key: :user_id

  has_many :visits,
    class_name: :Visit,
    primary_key: :id,
    foreign_key: :shortened_url_id

  has_many :visitors,
    Proc.new { distinct },
    through: :visits,
    source: :visitor

  has_many :taggings,
    class_name: :Tagging,
    primary_key: :id,
    foreign_key: :shortened_url_id

  has_many :topics,
    through: :taggings,
    source: :topic

  def num_clicks
    visits.count
  end

  def num_uniques
    # Visit.select(:user_id).distinct.count
    visitors.count
  end

  def num_recent_uniques
    Visit.select(:user_id)
      .distinct
      .where('created_at > :time', { time: 10.minutes.ago } )
      .count
  end
end
