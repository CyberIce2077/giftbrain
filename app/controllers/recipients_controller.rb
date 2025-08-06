class RecipientsController < ApplicationController
  before_action :authenticate_user!, except: %i[index]

  def index
    authorize(Recipient)

    recipients = policy_scope(Recipient).order(id: :desc)

    @toogle_menu = recipients.empty?

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
      flash[:notice] = 'Created successfully'

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
      flash[:notice] = 'Updated successfully'

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
      flash[:notice] = 'Deleted successfully'
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
