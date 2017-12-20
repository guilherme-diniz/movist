class Recommendation
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :recommendation_set
  belongs_to :movie


  field :like, type: Boolean
  rateable range: (1..10), raters: User
end
