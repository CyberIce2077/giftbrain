class GiftTargetsController < ApplicationController
  def index
    gift_targets = GiftTarget.order(id: :desc)

    render 'gift_targets/index', locals: { gift_targets: }
  end

  def show
    gift_target = find_gift_target

    if gift_target.draft_status?
      gift_target.pending_status!
      ::GiftIdeas::GeneratorJob.perform_later(gift_target)
    end

    gift_ideas = gift_target.gift_ideas
                            .joins(:gift_target_gift_ideas)
                            .order('gift_target_gift_ideas.priority ASC')

    render 'gift_targets/show', locals: { gift_target:, gift_ideas: }
  end

  def new
    gift_target = GiftTarget.new

    render 'gift_targets/new', locals: { gift_target: }
  end

  def create
    gift_target = GiftTarget.new(gift_target_params)

    gift_target.user = current_user

    gift_ideas = gift_target.gift_ideas.order(id: :desc)

    if gift_target.save
      render 'gift_targets/show', locals: { gift_target:, gift_ideas: }
    else
      render 'gift_targets/new', locals: { gift_target: }
    end
  end

  def edit
    gift_target = find_gift_target

    render 'gift_targets/edit', locals: { gift_target: }
  end

  def update
    gift_target = find_gift_target

    gift_ideas = gift_target.gift_ideas.order(id: :desc)

    if gift_target.update(gift_target_params)
      render 'gift_targets/show', locals: { gift_target:, gift_ideas: }
    else
      render 'gift_targets/edit', locals: { gift_target: }
    end
  end

  def destroy
    gift_target = find_gift_target

    if gift_target.destroy
      redirect_to [:gift_targets]
    end
  end

  def retry
    gift_target = find_gift_target

    gift_target.pending_status!
    ::GiftIdeas::GeneratorJob.perform_later(gift_target)

    gift_ideas = gift_target.gift_ideas.order(id: :desc)

    render 'gift_targets/show', locals: { gift_target:, gift_ideas: }
  end

  private

  def find_gift_target
    GiftTarget.find(params[:id])
  end

  def gift_target_params
    params.require(:gift_target).permit(gift_target_attrs)
  end

  def gift_target_attrs
    %i[name description]
  end
end
