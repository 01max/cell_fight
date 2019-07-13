class FightsController < ApplicationController
  before_action :set_fight, only: [:show]

  # GET /fights
  def index
    @pagy, @fights = pagy(Fight.all)
  end

  # GET /fights/1
  def show
  end

  # GET /fights/new
  def new
    @fight = Fight.new
  end

  # POST /fights
  def create
    @fight = Fight.new(fight_params)

    respond_to do |format|
      if @fight.save
        format.html {
          redirect_to [@fight],
          notice: t(
            'shared.notice.successful_creation',
            klass: Fight.model_name.human.humanize,
            instance: @fight
          )
        }
      else
        format.html { render :new }
      end
    end
  end

  private
    def set_fight
      @fight = Fight.find(params[:id])
    end

    def fight_attrs
      [
        :fighter_a_id,
        :fighter_b_id,
      ]
    end

    def fight_params
      params.require(:fight).permit(fight_attrs)
    end

end
