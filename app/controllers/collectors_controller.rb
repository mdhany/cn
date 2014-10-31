class CollectorsController < ApplicationController
  #before_filter :authenticate_collector!
  before_action :set_collector, only: :update

  def event
    @events = Event.where(["d_event >= ?", Date.today])
  end

  def edit_collector_event
    if current_collector.update_attribute :event_id, params[:event_id]
      redirect_to root_path
    else
      render event
      logger.debug "El Evento del Collector no pudo ser actualizado"
    end
  end

  def index
    @collectors = ::Collector::all
  end

  def edit

  end

  def update
    respond_to do |format|
      if @collector.update(customer_params)
        format.html { redirect_to end_path}
        format.json { render :show, status: :ok, location: @collector }

        if @collector.entry.update_attribute :completed, true
          logger.debug "Recolector #{@collector.entry_id} actualizado"
        end
      else
        format.html { render :edit }
        format.json { render json: @collector.errors, status: :unprocessable_entity }
      end
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_collector
    @collector = Collector.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def customer_params
    params.require(:collector).permit(:event_id, :name, :email, :password, :password_confirmation)
  end

end
