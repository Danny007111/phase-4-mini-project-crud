class SpicesController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

    def index
        spices = Spice.all
        render json: spices
      end
    
      def create
        spice = Spice.create(spice_parameters)
        render json: spice, status: :created
      end
    
      def update
        spice = Spice.find_by(id: params[:id])
        spice.update(spice_parameters)
        render json: spice
      end
    
      def destroy
        spice = Spice.find_by(id: params[:id])
        spice.destroy
        head :no_content
      end
    
      private
      
      def spice_parameters
        params.permit(:title, :image, :description, :notes, :rating)
      end

      def render_not_found_response
        render json: { error: "Spice not found" }, status: :not_found
      end
end
