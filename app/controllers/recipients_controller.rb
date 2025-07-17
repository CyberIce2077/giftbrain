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
      redirect_to [recipient]
    else
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
      render 'recipients/update', locals: { recipient: }
    else
      render 'recipients/edit', locals: { recipient: }
    end
  end

  def destroy
    recipient = find_recipient
    authorize(recipient)

    if recipient.destroy
      redirect_to [:recipients]
    end
  end

  def generate_ideas
    recipient = find_recipient
    authorize(recipient)

    recipient.pending_status!
    ::Ideas::GeneratorJob.perform_later(recipient)

    render 'recipients/generate_ideas', locals: { recipient: }
  end

  private

  def find_recipient
    policy_scope(Recipient).find(params[:id])
  end

  def recipient_params
    params.require(:recipient).permit(recipient_attrs)
  end

  def recipient_attrs
    %i[name description]
  end
end
