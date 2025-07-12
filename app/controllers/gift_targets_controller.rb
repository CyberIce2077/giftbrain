class GiftTargetsController < ApplicationController
  def index
    gift_targets = GiftTarget.order(id: :desc)

    render 'gift_targets/index', locals: { gift_targets: }
  end

  def show
    gift_target = find_gift_target

    render 'gift_targets/show', locals: { gift_target:, gift_ideas: }
  end

  def new
    gift_target = GiftTarget.new

    render 'gift_targets/new', locals: { gift_target: }
  end

  def create
    gift_target = GiftTarget.new(gift_target_params)

    gift_target.user = current_user

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

    if gift_target.update(gift_target_params)
      render 'gift_targets/show', locals: { gift_target:, gift_ideas: }
    else
      render 'gift_targets/edit', locals: { gift_target:, gift_ideas: }
    end
  end

  def destroy
    gift_target = find_gift_target

    if gift_target.destroy
      redirect_to [:gift_targets]
    else
      render 'gift_targets/edit', locals: { gift_target:, gift_ideas: }
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

  def gift_ideas
    return []

    response = HTTP.headers("Content-Type" => "application/json")
                  .gift_target("http://localhost:8080/v1/chat/completions", json: {
                    model: "phi-3-mini",
                    messages: [
                      {
                        role: "user",
                        content: build_prompt(gift_target)
                      }
                    ]
                  })

    json_string = JSON.parse(response.body.to_s)["choices"].first["message"]["content"]

    JSON.parse(json_string)
  end

  def build_prompt(gift_target)
    <<~PROMPT.strip
      I want to buy a gift for someone. Here's what I know about them: #{gift_target.description}.
      Suggest exactly 5 unique and thoughtful gift ideas that can be bought from #{web_sites}.

      Return the response strictly as a JSON array of objects.
      Each object must have:
      - "name": the name of the gift
      - "description": a short one-line description (under 20 words)

      Do not include any text before or after the JSON.
      Example format:
      [
        { "name": "Moon Lamp", "description": "A dimmable night light shaped like the moon." },
        { "name": "Retro Game Console", "description": "Nostalgic entertainment in a pocket-sized device." }
      ]
    PROMPT
  end

  def web_sites
    "Amazon, Etsy or Aliexpress"
  end
end
