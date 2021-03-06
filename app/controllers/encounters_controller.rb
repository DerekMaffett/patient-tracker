class EncountersController < ApplicationController
  before_action :set_encounter, only: [:show, :edit, :update, :destroy]

  # GET /encounters
  # GET /encounters.json
  def index
     @encounters = Encounter.all.includes(:user).order_name_and_time
  end

  def summary
    @encounters = Encounter.all.includes(:user).order_name_and_time

    #TODO: Map encounter_type values to an integer so that reults can be ordered
    #identical to encounters/new view
    @encounters_count = Encounter.group(:user_id, :encounter_type)
      .order(:user_id, :encounter_type).count

    respond_to do |format|
      format.html
      format.xls
    end
  end

  # GET /encounters/1
  # GET /encounters/1.json
  def show
  end

  # GET /encounters/new
  def new
    @encounter = Encounter.new
  end

  # GET /encounters/1/edit
  def edit
  end

  # POST /encounters
  # POST /encounters.json
  def create

    total = 0
    begin
      ActiveRecord::Base.transaction do
        encounter_types.each do |type, number|
          total += number.to_i
          number.to_i.times  do
            Encounter.create!(
              encounter_type: type.to_s.humanize(capitalize: false),
              encountered_on: encountered_on,
              user: current_user
            )
          end
        end
      end
    rescue ActiveRecord::ActiveRecordError => error
      STDERR.puts "Error in EncountersController#create: #{error.message}"
      redirect_to :new_encounter, alert: "Something went wrong!
                      Your encounters were not counted!
                      Please count again!"
    else
      if total == 0
        redirect_to :new_encounter, alert: 'You did not count your encounters!'
      else
        redirect_to :encounters, notice: 'Your encounters have been counted!'
      end
    end
  end

  # PATCH/PUT /encounters/1
  # PATCH/PUT /encounters/1.json
  def update
    respond_to do |format|
      if @encounter.update(encounter_params)
        format.html { redirect_to @encounter, notice: 'Encounter was successfully updated.' }
        format.json { render :show, status: :ok, location: @encounter }
      else
        format.html { render :edit }
        format.json { render json: @encounter.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /encounters/1
  # DELETE /encounters/1.json
  def destroy
    @encounter.destroy
    respond_to do |format|
      format.html { redirect_to encounters_url, notice: 'Encounter was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_encounter
      @encounter = Encounter.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def encounter_params
      params.require(:encounter).permit(:encounter_type)
    end

    # Require that params[:encountered_on] is not empty and return the value
    def encountered_on
      params.require(:encountered_on)
    end

    def encounter_types
      params.require(:encounter_types).permit(*Encounter::TYPES)
    end
end
