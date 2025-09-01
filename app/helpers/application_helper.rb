module ApplicationHelper
  def turnstile_widget
    return unless Rails.env.production?

    sitekey = Rails.application.credentials.dig(:cloudflare, :turnstile, :key)

    content_tag(:div, "", class: "cf-turnstile", data: { sitekey:, theme: "light" })
  end

  # TODO: use decorator
  def event_due_date(reminder)
    return "Event is today!" if reminder.same_day_kind?

    "Event is coming after #{reminder.kind}!".humanize
  end

  def progress_bar(target)
    content_tag(
      :div,
      class: "progress-container",
      data: {
        controller: "progress",
        progress_status_value: target.status,
        progress_duration_value: target.estimated_generation
      }
    ) do
      content_tag(
        :div,
        "",
        class: "progress-bar #{{"processing" => "green", "finishing" => "green", "success" => "green", "failed" => "red"}[target.status]}",
        data: { progress_target: "bar" }
      )
    end
  end
end
