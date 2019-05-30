# == Schema Information
#
# Table name: visits
#
#  id           :bigint           not null, primary key
#  user_id      :integer          not null
#  short_url_id :integer          not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Visit < ApplicationRecord
  validates :user_id, :short_url_id, presence: true

  belongs_to :users,
    primary_key: :id, 
    foreign_key: :user_id,
    class_name: :User 

  belongs_to :shortened_urls,
    primary_key: :id, 
    foreign_key: :short_url_id,
    class_name: :ShortenedUrl 

  def self.record_visit!(user, shortened_url)
    Visit.new(user_id: user.id, short_url_id: shortened_url.id).save
  end



end
