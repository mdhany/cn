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
      #Chivas Flask
      Gift.create!([type_g: 0, name: 'Chivas Flask', position: 10, event_id: params[:event_id], inventory: params[:gifts][:flask], predicted: params[:gifts][:flask], priority: 1, image: 'g-flask.jpg'])

      #Glasses
      Gift.create!([type_g: 0, name: 'Chivas Glasses', position: 140, event_id: params[:event_id], inventory: params[:gifts][:glasses], predicted: params[:gifts][:glasses], priority: 1, image: 'g-glasses.jpg'])
      Gift.create!([type_g: 0, name: 'Chivas Glasses', position: 205, event_id: params[:event_id], inventory: params[:gifts][:glasses1], predicted: params[:gifts][:glasses1], priority: 1, image: 'g-glasses.jpg'])

      #Acceso a Fiestas Fin de Año
      Gift.create!([type_g: 1, name: 'Acceso a Fiestas Fin de Año', position: 30, event_id: params[:event_id], inventory: params[:gifts][:fiesta], predicted:  params[:gifts][:fiesta], priority: 1, image: 'g-fiestas.jpg'])
      Gift.create!([type_g: 1, name: 'Acceso a Fiestas Fin de Año', position: 105, event_id: params[:event_id], inventory: params[:gifts][:fiesta1], predicted:  params[:gifts][:fiesta1], priority: 1, image: 'g-fiestas.jpg'])
      Gift.create!([type_g: 1, name: 'Acceso a Fiestas Fin de Año', position: 185, event_id: params[:event_id], inventory: params[:gifts][:fiesta2], predicted:  params[:gifts][:fiesta2], priority: 1, image: 'g-fiestas.jpg'])
      Gift.create!([type_g: 1, name: 'Acceso a Fiestas Fin de Año', position: 320, event_id: params[:event_id], inventory: params[:gifts][:fiesta3], predicted:  params[:gifts][:fiesta3], priority: 1, image: 'g-fiestas.jpg'])

      #Chivas 375 ml
      Gift.create!([type_g: 2, name: 'Chivas 50 ml', position: 55, event_id: params[:event_id], inventory: params[:gifts][:ml], predicted: params[:gifts][:ml], priority: 1, image: 'g-ml.jpg'])
      Gift.create!([type_g: 2, name: 'Chivas 50 ml', position: 250, event_id: params[:event_id], inventory: params[:gifts][:ml1], predicted: params[:gifts][:ml1], priority: 1, image: 'g-ml.jpg'])

      #Chivas Work Kit
        Gift.create!([type_g: 3, name: 'Chivas Work Kit', position: 85, event_id: params[:event_id], inventory: params[:gifts][:kit], predicted: params[:gifts][:kit], priority: 1, image: 'g-kit.jpg'])
        Gift.create!([type_g: 3, name: 'Chivas Work Kit', position: 160, event_id: params[:event_id], inventory: params[:gifts][:kit1], predicted: params[:gifts][:kit1], priority: 1, image: 'g-kit.jpg'])
        Gift.create!([type_g: 3, name: 'Chivas Work Kit', position: 275, event_id: params[:event_id], inventory: params[:gifts][:kit2], predicted: params[:gifts][:kit2], priority: 1, image: 'g-kit.jpg'])
      #Chivas Catas
        Gift.create!([type_g: 4, name: 'Chivas Catas', position: 340, event_id: params[:event_id], inventory: params[:gifts][:catas], predicted: params[:gifts][:catas], priority: 1, image: 'g-catas.jpg'])
        Gift.create!([type_g: 4, name: 'Chivas Catas', position: 120, event_id: params[:event_id], inventory: params[:gifts][:catas1], predicted: params[:gifts][:catas1], priority: 1, image: 'g-catas.jpg'])
        Gift.create!([type_g: 4, name: 'Chivas Catas', position: 225, event_id: params[:event_id], inventory: params[:gifts][:catas2], predicted: params[:gifts][:catas2], priority: 1, image: 'g-catas.jpg'])
      #Chivas 12 años Tin 750ml
        Gift.create!([type_g: 5, name: 'Chivas 12 años Tin 750ml', position: 300, event_id: params[:event_id], inventory: params[:gifts][:tin], predicted: params[:gifts][:tin], priority: 1, image: 'g-tin.jpg'])

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
