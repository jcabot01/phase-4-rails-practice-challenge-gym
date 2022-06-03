class ClientsController < ApplicationController
  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response 
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

  #GET /clients
  def index 
    clients = Client.all 
    render json: clients, except:[:total_amount], status: :ok
  end

  #GET /clients/:id
  def show
    client = find_client
    render json: client, status: :ok
  end

  #PATCH /clients/:id
  def update
    client = find_client
    client.update!(client_params)
    render json: client, status: :accepted
  end


  private
  
  def client_params
    params.permit(:name, :age)
  end

  def find_client
    Client.find(params[:id])
  end

  def render_unprocessable_entity_response(exception)
    render json: { errors:exception.record.errors.full_messages }, status: :unprocessable_entity
  end

  def render_not_found_response
    render json: { error: "Client not found" }, status: :not_found
  end
end
