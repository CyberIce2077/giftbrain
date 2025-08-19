module Discardable
  extend ActiveSupport::Concern

  class DestroyNotAllowedError < StandardError; end

  included do
    before_destroy :validate_destroy!

    scope :active, -> { where(discarded_at: nil) }
  end

  def discarded?
    discarded_at.present?
  end

  def discard!
    update!(discarded_at: Time.zone.now)
  end

  def restore!
    update!(discarded_at: nil)
  end

  private

  def validate_destroy!
    return if destroyed_by_association

    raise DestroyNotAllowedError, "Cannot delete directly. Only parent may delete this record"
  end
end
