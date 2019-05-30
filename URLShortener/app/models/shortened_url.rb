require "securerandom"
# == Schema Information
#
# Table name: shortened_urls
#
#  id         :bigint           not null, primary key
#  long_url   :string           not null
#  short_url  :string           not null
#  user_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class ShortenedUrl < ApplicationRecord
  include SecureRandom
  validates :long_url, :short_url, presence: true, uniqueness: true
  validates :user_id, presence: true

  belongs_to :submitter,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :User

  
  has_many :visits,
    primary_key: :id, 
    foreign_key: :short_url_id,
    class_name: :Visit 

  has_many :visitors,
    through: :visits,
    source: :users


  def self.create!(user, long_url) 
    ShortenedUrl.new(long_url: long_url, user_id: user.id, short_url: ShortenedUrl.random_code).save 
  end

  def self.random_code
    code = SecureRandom.urlsafe_base64
    until !ShortenedUrl.exists?(code)
      code = SecureRandom.urlsafe_base64
    end
    code
  end
end
