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

      #type_g: 10 es para los regalos en blanco. Estos deben tener inventario para que funcionen correctamente
      #Gift.create!([type_g: 10, name: 'Regalo EN BLANCO', position: 300, event_id: params[:event_id], inventory: 10, predicted:  10, priority: 1])
      #Gift.create!([type_g: 10, name: 'Regalo EN BLANCO', position: 120, event_id: params[:event_id], inventory: 10, predicted:  10, priority: 1])

      #Regalos normales
      Gift.create!([type_g: 0, name: 'Power Banks', position: 170, event_id: params[:event_id], inventory: params[:gifts][:power1], predicted: params[:gifts][:power1], priority: 1, image: 'r-PowerBanks.jpg'])
      #Gift.create!([type_g: 0, name: 'Power Banks', position: 140, event_id: params[:event_id], inventory: params[:gifts][:power2], predicted: params[:gifts][:power2], priority: 1, image: 'r-PowerBanks.jpg'])

      Gift.create!([type_g: 0, name: 'Tumblers', position: 120, event_id: params[:event_id], inventory: params[:gifts][:tumblers1], predicted: params[:gifts][:tumblers1], priority: 1, image: 'r-Tumblers.jpg'])
      #Gift.create!([type_g: 0, name: 'Tumblers', position: 160, event_id: params[:event_id], inventory: params[:gifts][:tumblers2], predicted: params[:gifts][:tumblers2], priority: 1, image: 'r-Tumblers.jpg'])

      Gift.create!([type_g: 0, name: 'Pocket Knife', position: 80, event_id: params[:event_id], inventory: params[:gifts][:pocket1], predicted: params[:gifts][:pocket1], priority: 1, image: 'r-PocketKnife.jpg'])
      #Gift.create!([type_g: 0, name: 'Pocket Knife', position: 185, event_id: params[:event_id], inventory: params[:gifts][:pocket2], predicted: params[:gifts][:pocket2], priority: 1, image: 'r-PocketKnife.jpg'])
      
      Gift.create!([type_g: 0, name: 'Selfie Stick', position: 30, event_id: params[:event_id], inventory: params[:gifts][:selfie1], predicted: params[:gifts][:selfie1], priority: 1, image: 'r-SelfieStick.jpg'])
      #Gift.create!([type_g: 0, name: 'Selfie Stick', position: 205, event_id: params[:event_id], inventory: params[:gifts][:selfie2], predicted: params[:gifts][:selfie2], priority: 1, image: 'r-SelfieStick.jpg'])
      
      Gift.create!([type_g: 0, name: 'Earbuds', position: 220, event_id: params[:event_id], inventory: params[:gifts][:earbuds1], predicted: params[:gifts][:earbuds1], priority: 1, image: 'r-Earbuds.jpg'])
      #Gift.create!([type_g: 0, name: 'Earbuds', position: 225, event_id: params[:event_id], inventory: params[:gifts][:earbuds2], predicted: params[:gifts][:earbuds2], priority: 1, image: 'r-Earbuds.jpg'])
      
      Gift.create!([type_g: 0, name: 'Posavasos', position: 330, event_id: params[:event_id], inventory: params[:gifts][:posavasos1], predicted: params[:gifts][:posavasos1], priority: 1, image: 'r-Posavasos.jpg'])
      #Gift.create!([type_g: 0, name: 'Posavasos', position: 250, event_id: params[:event_id], inventory: params[:gifts][:posavasos2], predicted: params[:gifts][:posavasos2], priority: 1, image: 'r-Posavasos.jpg'])
      
      Gift.create!([type_g: 0, name: 'Gorras', position: 270, event_id: params[:event_id], inventory: params[:gifts][:gorras1], predicted: params[:gifts][:gorras1], priority: 1, image: 'r-Gorra.jpg'])
      #Gift.create!([type_g: 0, name: 'Gorras', position: 275, event_id: params[:event_id], inventory: params[:gifts][:gorras2], predicted: params[:gifts][:gorras2], priority: 1, image: 'r-Gorra.jpg'])




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
