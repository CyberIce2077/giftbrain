class RecipientSerializer < BaseSerializer
  attributes :id, :title, :start, :url

  def title
    object.name
  end

  def start
    object.event_date
  end

  def url
    Rails.application.routes.url_helpers.recipient_path(object)
  end
end
