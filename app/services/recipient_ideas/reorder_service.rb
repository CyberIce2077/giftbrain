module RecipientIdeas
  class ReorderService < BaseService
    attr_reader :recipient, :idea_ids

    class ReorderError < StandardError; end

    def initialize(recipient, idea_ids)
      super
      @recipient = recipient
      @idea_ids = idea_ids
    end

    def call
      validate_idea_ids!

      id_priority_pairs = idea_ids.each_with_index.map { |id, index| [id, index + 1] }.to_h

      case_sql = id_priority_pairs.map { |key, value| "WHEN #{key} THEN #{value}" }.join(" ")

      idea_ids_sql = id_priority_pairs.keys.join(",")

      sql = <<~SQL
        UPDATE recipient_ideas
        SET priority = CASE idea_id #{case_sql} END
        WHERE recipient_id = #{recipient.id} AND idea_id IN (#{idea_ids_sql})
      SQL

      ActiveRecord::Base.connection.execute(sql)

      success!
    rescue StandardError => e
      general_error_message
      log_error(e)
    end

    private

    def validate_idea_ids!
      return if idea_ids.all? { |id| id.is_a?(Integer) } && idea_ids.size == recipient.recipient_ideas.size

      raise ReorderError, "Invalid idea_ids"
    end
  end
end
