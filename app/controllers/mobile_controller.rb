class MobileController < ApplicationController

  def start

  end


  def participate
    #buscar o crear customer
    #crear factura
    #mostrar lightbox con mensaje de listo

    customer = Customer.find_or_create_by(identification: params[:identification]) do |c|
      c.name = params[:name]
      c.birth = params[:birth]
      c.mobile = params[:mobile]
      c.email = params[:email]
      c.invoices.build([{number: params[:number], picture: params[:picture]}])
    end

    respond_to do |format|
      if customer
        format.html { redirect_to action: :start, anchor: 'inline'}
        format.js
      end
    end

  end


  def upload
    uploaded_io = params[:picture]
    File.open(Rails.root.join('public', 'uploads', uploaded_io.original_filename), 'wb') do |file|
      file.write(uploaded_io.read)
    end
    #"http://#{request.host_with_port}/uploads/#{uploaded_io.original_filename}"
  end

end
