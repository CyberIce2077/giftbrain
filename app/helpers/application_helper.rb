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
end
