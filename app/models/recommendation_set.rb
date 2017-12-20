class RecommendationSet
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :user
  has_many :recommendations
end
