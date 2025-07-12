class GiftTargetsController < ApplicationController
  def index
    gift_targets = GiftTarget.order(id: :desc)

    render 'gift_targets/index', locals: { gift_targets: }
  end

  def show
    gift_target = find_gift_target

    render 'gift_targets/show', locals: { gift_target: }
  end

  def new
    gift_target = GiftTarget.new

    render 'gift_targets/new', locals: { gift_target: }
  end

  def create
    gift_target = GiftTarget.new(gift_target_params)

    gift_target.user = current_user

    if gift_target.save
      # redirect_to [:gift_targets]
      render 'gift_targets/show', locals: { gift_target: }
    else
      render 'gift_targets/new', locals: { gift_target: }
    end
  end

  private

  def find_gift_target
    GiftTarget.find(params[:id])
  end

  def gift_target_params
    permitted = [:name, :description]

    params.require(:gift_target).permit(permitted)
  end
end
