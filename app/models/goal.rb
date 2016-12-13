class Goal < ActiveRecord::Base
  validates :user, :goal_name, presence: true

  belongs_to :user
  has_many :goal_comments

  attr_accessor :completed
end
