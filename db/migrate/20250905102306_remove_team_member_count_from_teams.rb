class RemoveTeamMemberCountFromTeams < ActiveRecord::Migration[8.0]
  def change
    remove_column :teams, :team_members_count, :integer, default: 0, null: false
  end
end
