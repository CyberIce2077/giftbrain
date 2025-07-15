class RecipientsController < ApplicationController
  def index
    recipients = Recipient.order(id: :desc)

    render 'recipients/index', locals: { recipients: }
  end

  def show
    recipient = find_recipient

    ideas = recipient.ideas.order('recipient_ideas.priority ASC')

    render 'recipients/show', locals: { recipient:, ideas: }
  end

  def new
    recipient = Recipient.new

    render 'recipients/new', locals: { recipient: }
  end

  def create
    recipient = Recipient.new(recipient_params)

    recipient.creator = current_user

    ideas = recipient.ideas.order(id: :desc)

    if recipient.save
      render 'recipients/show', locals: { recipient:, ideas: }
    else
      render 'recipients/new', locals: { recipient: }
    end
  end

  def edit
    recipient = find_recipient

    render 'recipients/edit', locals: { recipient: }
  end

  def update
    recipient = find_recipient

    ideas = recipient.ideas.order(id: :desc)

    if recipient.update(recipient_params)
      render 'recipients/show', locals: { recipient:, ideas: }
    else
      render 'recipients/edit', locals: { recipient: }
    end
  end

  def destroy
    recipient = find_recipient

    if recipient.destroy
      redirect_to [:recipients]
    end
  end

  def generate_ideas
    recipient = find_recipient

    recipient.pending_status!
    ::Ideas::GeneratorJob.perform_later(recipient)

    render 'recipients/generate_ideas', locals: { recipient: }
  end

  private

  def find_recipient
    Recipient.find(params[:id])
  end

  def recipient_params
    params.require(:recipient).permit(recipient_attrs)
  end

  def recipient_attrs
    %i[name description]
  end
end
