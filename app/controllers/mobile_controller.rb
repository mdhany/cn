class MobileController < ApplicationController
  before_action :authenticate_collector!
  before_filter :api_graph, only: [:select_friend, :publishing_post]

  def start
    destroy_session_customer
    #desconectar de fb
    #Limpiar las sesiones
  end

  def social
    #Login at Facebook
    @oauth = Koala::Facebook::OAuth.new(posting_url)
    @aut_fb = @oauth.url_for_oauth_code(:permissions => "public_profile,email,publish_actions,user_friends,user_photos", :display => 'popup' )

  end

  def creating_post
    @oauth = Koala::Facebook::OAuth.new(posting_url)
    #Save session for token-fb
    session[:token_fb] = @oauth.get_access_token(params[:code])
    #Loading GraphAPI
    @graph = Koala::Facebook::GraphAPI.new(session[:token_fb])
    #Listing all Friends
    @me = @graph.get_object("me")
  end

  def create_customer(email, name)
    cu = Customer.create!(email: email, name: name)
    session[:customer_id] = cu.id
  end

  def select_activity
    unless current_customer #Si no hay un customer logueado...
      cu = Customer.get_customer(params[:email])
      if cu #Si ya esta registrado
        session[:customer_id] = cu.id
      else #Crear el customer con la data de fb
        create_customer(params[:email], params[:name])
      end
    end
    #Crear el Entry
    en = Entry.create!(customer_id: current_customer.id, post: params[:post], event_id: current_collector.event_id)
    current_customer.update_attribute :entry_id, en.id

    redirect_to select_friend_path
  end

  def select_friend
    @friends = @graph.get_connections("me", "taggable_friends")
  end

  def publishing_post
    #Subir Imagen a server
    image = upload
    amigos = params[:friends]
    if image
      #Subir imagen  a FB
        img = @graph.put_picture(params[:picture],  {:message => "#{current_customer.entry.post} #ChivasNights"}, 'ChivasDominicana')
      #Taguear Amigos
        params[:friends].each_value do |f|
          @graph.put_object(img['id'], 'tags', :tag_uid => f )
        end
        @graph.put_object(img['id'], 'tags', :tag_text => '@ChivasDominicana' )
    else
      redirect_to select_friend_path, notice: 'Por favor, vuelva a intentar.'
    end

    redirect_to ruleta_path
  end

  def upload
    uploaded_io = params[:picture]
    File.open(Rails.root.join('public', 'uploads', uploaded_io.original_filename), 'wb') do |file|
      file.write(uploaded_io.read)
    end
  end

  def spin
    #Habra un arras con todos los regalos, y se ejecutara un random entre ellos.
    #Cuando salga debe ser debitado del historial
    #Debe ser asignado a la entrada
    gifts = nil
    gifts = Gift.where(["event_id = ? and inventory > 0", current_collector.event_id])
    @win = nil
    @win = gifts.sample
  end

  def save_gift
    gift = Gift.find params[:gift_id]

      #Restar el regalo ganado
      if gift.update_attribute :inventory, gift.inventory - 1
        if current_customer.entry.update_attributes!(gift: gift.name, completed: true)
          redirect_to club_path
        end
      else
        logger.debug "No pudo ser guargado el gift"
      end

  end

  def club
    if current_customer
      @customer = Customer.find(current_customer)
    else
      @customer = Customer.new
    end
  end

  def end

  end

  protected
  def api_graph
  @graph = Koala::Facebook::GraphAPI.new(session[:token_fb])
  end
end
