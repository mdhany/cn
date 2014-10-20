class CollectorsController < ApplicationController
  before_filter :authenticate_collector!

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

end
