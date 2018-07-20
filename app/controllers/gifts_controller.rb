class GiftsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_gift, only: [:show, :edit, :update, :destroy]

  # GET /gifts
  # GET /gifts.json
  def index
    @gifts = Gift.all
  end

  # GET /gifts/1
  # GET /gifts/1.json
  def show
  end

  # GET /gifts/new
  def new
    @gift = Gift.new
  end

  # GET /gifts/1/edit
  def edit
  end

  # POST /gifts
  # POST /gifts.json
  def create
    @gift = Gift.new(gift_params)

    respond_to do |format|
      if @gift.save
        format.html { redirect_to @gift, notice: 'Gift was successfully created.' }
        format.json { render :show, status: :created, location: @gift }
      else
        format.html { render :new }
        format.json { render json: @gift.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /gifts/1
  # PATCH/PUT /gifts/1.json
  def update
    respond_to do |format|
      if @gift.update(gift_params)
        format.html { redirect_to @gift, notice: 'Gift was successfully updated.' }
        format.json { render :show, status: :ok, location: @gift }
      else
        format.html { render :edit }
        format.json { render json: @gift.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /gifts/1
  # DELETE /gifts/1.json
  def destroy
    @gift.destroy
    respond_to do |format|
      format.html { redirect_to gifts_url, notice: 'Gift was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def generate_gifts

  end

  def creating_gifts
    g = Event.find params[:event_id]
    if g.gifts.blank?

      #type_g: 5 es para regalos de alto costo.
      #type_g: 10 es para los regalos en blanco. Estos deben tener inventario para que funcionen correctamente
      #Gift.create!([type_g: 10, name: 'Regalo EN BLANCO', position: 300, event_id: params[:event_id], inventory: 10, predicted:  10, priority: 1])  
      Gift.create!([type_g: 10, name: 'Sin Regalo', position: 105, event_id: params[:event_id], inventory: 10, predicted:  10, priority: 1])
      Gift.create!([type_g: 10, name: 'Sin Regalo', position: 205, event_id: params[:event_id], inventory: 10, predicted:  10, priority: 1])
      Gift.create!([type_g: 10, name: 'Sin Regalo', position: 340, event_id: params[:event_id], inventory: 10, predicted:  10, priority: 1])

      #Regalos normales
      Gift.create!([type_g: 0, name: 'Echo Speaker', position: 10, event_id: params[:event_id], inventory: params[:gifts][:echo], predicted: params[:gifts][:echo], priority: 1, image: 'r-EchoSpeaker.jpg'])
      Gift.create!([type_g: 0, name: 'Chivas Extra 50ml', position: 55, event_id: params[:event_id], inventory: params[:gifts][:chivas50], predicted: params[:gifts][:chivas50], priority: 1, image: 'r-ChivasExtra50ml.jpg'])
      Gift.create!([type_g: 0, name: 'Bartender Set', position: 140, event_id: params[:event_id], inventory: params[:gifts][:bartender], predicted: params[:gifts][:bartender], priority: 1, image: 'r-BartenderSet.jpg'])
      Gift.create!([type_g: 0, name: 'Chivas 12 750ml', position: 185, event_id: params[:event_id], inventory: params[:gifts][:chivas12], predicted: params[:gifts][:chivas12], priority: 1, image: 'r-Chivas12.jpg'])
      Gift.create!([type_g: 0, name: 'HyperChiller', position: 250, event_id: params[:event_id], inventory: params[:gifts][:hyper], predicted: params[:gifts][:hyper], priority: 1, image: 'r-Hyperchiller.jpg'])
      Gift.create!([type_g: 0, name: 'Wireless Charger', position: 300, event_id: params[:event_id], inventory: params[:gifts][:charger], predicted: params[:gifts][:charger], priority: 1, image: 'r-WirelessCharger.jpg'])



      redirect_to event_path(params[:event_id]), notice: "Todos los regalos fueron creados"
    else
      redirect_to event_path(params[:event_id]), notice: "Ya este evento contiene Regalos. Por favor editarlos"
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_gift
      @gift = Gift.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def gift_params
      params.require(:gift).permit(:name, :inventory, :predicted, :priority, :event_id)
    end
end
