class Recipient < ApplicationRecord
  AVERAGE_GENERATE_DURATION = 10

  before_validation :strip_whitespace

  belongs_to :creator, class_name: "User"
  has_many :recipient_ideas, dependent: :destroy
  has_many :ideas, through: :recipient_ideas
  has_many :reminders, dependent: :destroy
  has_one :team, dependent: :destroy
  has_many :team_members, through: :team
  has_many :favorite_products, dependent: :destroy

  accepts_nested_attributes_for :reminders, allow_destroy: false

  validates :name, :description, :event_date, presence: true
  validates :name, length: { maximum: 50 }
  validates :description, length: { maximum: 300 }

  enum :status, { draft: 0, pending: 1, processing: 2, finishing: 3, success: 4, failed: 5 }, suffix: true

  scope :repeat_annually, -> { where(repeat_annually: true) }
  scope :with_subscribed_creator, -> { joins(:creator).merge(User.subscribed) }
  scope :with_teams, -> { includes(:team) }

  def editable?
    draft_status? || failed_status? || success_status?
  end

  def build_recipient
    Reminder.kinds.each_key do |kind|
      next if reminders.any? { |r| r.kind == kind.to_s }

      reminders.build(kind:, active: %w[same_day one_month].include?(kind))
    end
  end

  def update_recipient_view(status)
    case status
    when :processing
      processing_status!
    when :finishing
      finishing_status!
    when :success
      success_status!
    when :failed
      failed_status!
    end

    broadcast_update_to(
      self,
      target: self,
      partial: "/recipients/recipient_options",
      locals: { recipient: self }
    )
  end

  private

  def strip_whitespace
    self.name = name.to_s.strip
    self.description = description.to_s.strip
  end
end
