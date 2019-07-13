class FightersController < ApplicationController
  before_action :set_fighter, only: [:show, :edit, :update, :destroy]

  # GET /fighters
  def index
    @pagy, @fighters = pagy(Fighter.all)
  end

  # GET /fighters/1
  def show
    @won_fights = @fighter.won_fights
  end

  # GET /fighters/new
  def new
    @fighter = Fighter.new
  end

  # GET /fighters/1/edit
  def edit
  end

  # POST /fighters
  def create
    @fighter = Fighter.new(fighter_params)

    respond_to do |format|
      if @fighter.save
        format.html {
          redirect_to [@fighter],
          notice: t(
            'shared.notice.successful_creation',
            klass: Fighter.model_name.human.humanize,
            instance: @fighter
          )
        }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /fighters/1
  def update
    respond_to do |format|
      if @fighter.update(fighter_params)
        format.html {
          redirect_to [@fighter],
          notice: t(
            'shared.notice.successful_update',
            klass: Fighter.model_name.human.humanize,
            instance: @fighter
          )
        }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /fighters/1
  def destroy
    @fighter.destroy
    respond_to do |format|
      format.html {
        redirect_to admin_fighters_url,
        notice: t(
          'shared.notice.successful_destruction',
          klass: Fighter.model_name.human.humanize,
          instance: @fighter
        )
      }
    end
  end

  private
    def set_fighter
      @fighter = Fighter.find(params[:id])
    end

    def fighter_attrs
      [
        :name,
        :attack_base_points,
        :defense_base_points,
        :health_base_points,
        :color_code
      ]
    end

    def fighter_params
      params.require(:fighter).permit(fighter_attrs)
    end

end
