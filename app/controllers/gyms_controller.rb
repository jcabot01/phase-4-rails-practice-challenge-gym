class GymsController < ApplicationController
  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response 
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

  #GET /gyms
  def index 
    gyms = Gym.all 
    render json: gyms, status: :ok
  end

  #GET /gyms/:id
  def show
    gym = find_gym
    render json: gym, status: :ok
  end

  #PATCH /gyms/:id
  def update
    gym = find_gym
    gym.update!(gym_params)
    render json: gym, status: :accepted
  end

  #DELETE /gyms/:id
  def destroy
    gym = find_gym
    gym.destroy 
    head :no_content 
  end


  private
  def gym_params
    params.permit(:name, :address)
  end

  def find_gym
    Gym.find(params[:id])
  end

  def render_unprocessable_entity_response(exception)
    render json: { errors:exception.record.errors.full_messages }, status: :unprocessable_entity
  end

  def render_not_found_response
    render json: { error: "Gym not found" }, status: :not_found
  end
end
