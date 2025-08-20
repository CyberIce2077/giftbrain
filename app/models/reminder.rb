class Reminder < ApplicationRecord
  include Discardable

  belongs_to :recipient

  enum :kind, { same_day: 0, one_day: 1, one_week: 2, one_month: 3 }, suffix: true

  validates :kind, presence: true

  scope :active, -> { where(active: true) }
end
