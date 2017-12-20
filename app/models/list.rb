class List
  include Mongoid::Document

  belongs_to :user
  has_and_belongs_to_many :movies

  field :title, type: String
  field :description, type: String
end
