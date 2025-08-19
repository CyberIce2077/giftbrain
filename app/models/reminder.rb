class Reminder < ApplicationRecord
  include Discardable

  belongs_to :recipient

  enum :kind, { same_day: 0, one_day: 1, one_week: 2, one_month: 3 }, suffix: true

  attribute :active, :boolean, default: false

  validates :kind, presence: true

  def active = !discarded?

  def active=(value)
    sanitized_value = ActiveModel::Type::Boolean.new.cast(value)

    return if discarded? && !sanitized_value

    self.discarded_at = sanitized_value ? nil : Time.zone.now
  end
end
