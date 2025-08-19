class Recipient < ApplicationRecord
  AVERAGE_GENERATE_DURATION = 10

  belongs_to :creator, class_name: "User"
  has_many :recipient_ideas, dependent: :destroy
  has_many :ideas, through: :recipient_ideas
  has_many :reminders, dependent: :destroy
  accepts_nested_attributes_for :reminders, allow_destroy: false

  validates :name, :description, :event_date, presence: true
  validates :name, length: { maximum: 50 }
  validates :description, length: { maximum: 300 }

  enum :status, { draft: 0, pending: 1, processing: 2, finishing: 3, success: 4, failed: 5 }, suffix: true

  scope :with_repeat_annually, -> { where(repeat_annually: true) }

  def editable?
    draft_status? || failed_status? || success_status?
  end

  def increment_ideas_count!
    update!(ideas_count: ideas_count + 1)
  end

  def decrement_ideas_count!
    update!(ideas_count: ideas_count - 1) if ideas_count > 0
  end

  def reset_ideas_count!
    update!(ideas_count: recipient_ideas.count)
  end

  def estimated_generation
    return AVERAGE_GENERATE_DURATION if generation_duration.zero?

    generation_duration
  end

  def build_recipient
    Reminder.kinds.each_key do |kind|
      next if reminders.any? { |r| r.kind == kind.to_s }

      reminders.build(kind:, active: %w[same_day one_month].include?(kind))
    end
  end
end
