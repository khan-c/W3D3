# == Schema Information
#
# Table name: visits
#
#  id               :integer          not null, primary key
#  user_id          :integer          not null
#  shortened_url_id :integer          not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class Visit < ApplicationRecord
  def self.record_visit!(user, shortened_url)
    Visit.create(user_id: user.id, shortened_url_id: shortened_url.id)
  end

  belongs_to :visitor,
    class_name: :User,
    primary_key: :id,
    foreign_key: :user_id

  belongs_to :visit,
    class_name: :ShortenedUrl,
    primary_key: :id,
    foreign_key: :shortened_url_id

end
