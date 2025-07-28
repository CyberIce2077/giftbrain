class DashboardController < ApplicationController
  def index
    authorize :dashboard
    skip_policy_scope

    user_count = User.count
    recipient_count = Recipient.count
    idea_count = Idea.count

    failed_jobs_count = Sidekiq::Stats.new.failed

    render "dashboard/index",
           locals: { user_count:,
                     recipient_count:,
                     idea_count:,
                     failed_jobs_count:
                    }
  end
end
