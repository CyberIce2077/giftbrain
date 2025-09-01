class RecipientsController < ApplicationController
  before_action :authenticate_user!, except: %i[index]

  def index
    authorize(Recipient)

    recipients = policy_scope(Recipient).page(params[:page]).order(id: :desc)

    teams = policy_scope(Team).where(recipient: recipients.map(&:id))

    @toogle_menu = recipients.blank?

    render "recipients/index", locals: { recipients:, teams: }
  end

  def show
    recipient = find_recipient
    authorize(recipient)

    ideas =  policy_scope(recipient.ideas).order("recipient_ideas.priority ASC")
    team = recipient.team

    render "recipients/show", locals: { recipient:, ideas:, team: }
  end

  def new
    recipient = Recipient.new
    authorize(recipient)

    recipient.build_recipient

    render "recipients/new", locals: { recipient: }
  end

  def create
    recipient = Recipient.new(recipient_params)
    authorize(recipient)

    recipient.creator = current_user

    if recipient.save
      flash[:notice] = "Created successfully"

      redirect_to [recipient]
    else
      flash[:warning] = recipient.errors.full_messages.to_sentence

      render "recipients/new", locals: { recipient: }
    end
  end

  def edit
    recipient = find_recipient
    authorize(recipient)

    recipient.build_recipient

    render "recipients/edit", locals: { recipient: }
  rescue Pundit::NotAuthorizedError => e
    if recipient.editable?
      flash[:warning] = "Not authorized"
    else
      flash[:warning] = "The AI is thinking… Editing will be unlocked once it's done!"
    end

    redirect_to [recipient]
  end

  def update
    recipient = find_recipient
    authorize(recipient)

    if recipient.update(recipient_params)
      if recipient.saved_change_to_event_date?
        recipient.reminders.find_each(&:restore!)
      end

      flash[:notice] = "Updated successfully"

      redirect_to [recipient]
    else
      flash[:warning] = recipient.errors.full_messages.to_sentence

      render "recipients/edit", locals: { recipient: }
    end
  rescue Pundit::NotAuthorizedError => e
    if recipient.editable?
      flash[:warning] = "Not authorized"
    else
      flash[:warning] = "The AI is thinking… Editing will be unlocked once it's done!"
    end

    redirect_to [recipient]
  end

  def destroy
    recipient = find_recipient
    authorize(recipient)

    if recipient.destroy
      flash[:notice] = "Deleted successfully"

      redirect_to recipients_url
    else
      flash[:warning] = recipient.errors.full_messages.to_sentence

      redirect_to [recipient]
    end
  rescue Pundit::NotAuthorizedError => e
    if recipient.editable?
      flash[:warning] = "Not authorized"
    else
      flash[:warning] = "The AI is thinking… Deleting will be unlocked once it's done!"
    end

    redirect_to [recipient]
  end

  def generate_ideas
    recipient = find_recipient
    authorize(recipient)

    recipient.pending_status!
    ::Ideas::GeneratorJob.perform_later(recipient)

    render "recipients/generate_ideas", locals: { recipient: }
  end

  private

  def find_recipient
    policy_scope(Recipient).find(params[:id])
  end

  def recipient_params
    params.require(:recipient).permit(recipient_attrs)
  end

  def recipient_attrs
    [:name, :description, :event_date, :repeat_annually, reminders_attributes: [:id, :kind, :active]]
  end
end
