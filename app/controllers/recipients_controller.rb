class RecipientsController < ApplicationController
  def index
    authorize(Recipient)

    recipients = policy_scope(Recipient).order(id: :desc)

    render 'recipients/index', locals: { recipients: }
  end

  def show
    recipient = find_recipient
    authorize(recipient)

    ideas =  policy_scope(recipient.ideas).order('recipient_ideas.priority ASC')

    render 'recipients/show', locals: { recipient:, ideas: }
  end

  def new
    recipient = Recipient.new
    authorize(recipient)

    render 'recipients/new', locals: { recipient: }
  end

  def create
    recipient = Recipient.new(recipient_params)
    authorize(recipient)

    recipient.creator = current_user

    if recipient.save
      flash[:notice] = 'Recipient created successfully'

      redirect_to [recipient]
    else
      flash[:warning] = recipient.errors.full_messages.to_sentence

      render 'recipients/new', locals: { recipient: }
    end
  end

  def edit
    recipient = find_recipient
    authorize(recipient)

    render 'recipients/edit', locals: { recipient: }
  end

  def update
    recipient = find_recipient
    authorize(recipient)

    if recipient.update(recipient_params)
      flash[:notice] = 'Recipient updated successfully'

      render 'recipients/update', locals: { recipient: }
    else
      flash[:warning] = recipient.errors.full_messages.to_sentence

      render 'recipients/edit', locals: { recipient: }
    end
  end

  def destroy
    recipient = find_recipient
    authorize(recipient)

    if recipient.destroy
      flash[:notice] = 'Recipient deleted successfully'
    else
      flash[:warning] = recipient.errors.full_messages.to_sentence
    end

    redirect_to [:recipients]
  end

  def generate_ideas
    recipient = find_recipient
    authorize(recipient)

    recipient.pending_status!
    ::Ideas::GeneratorJob.perform_later(recipient)

    render 'recipients/generate_ideas', locals: { recipient: }
  end

  def event_dates
    authorize(Recipient)

    recipients = policy_scope(Recipient).where(event_date: params[:start]..params[:end])

    respond_to do |format|
      format.json do
        render json: recipients.map { |recipient|
          {
            id: recipient.id,
            title: recipient.name,
            start: recipient.event_date,
            url: Rails.application.routes.url_helpers.recipient_path(recipient)
          }
        }
      end
    end
  end

  private

  def find_recipient
    policy_scope(Recipient).find(params[:id])
  end

  def recipient_params
    params.require(:recipient).permit(recipient_attrs)
  end

  def recipient_attrs
    %i[name description event_date]
  end
end
