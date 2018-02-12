module Api
  module V1
    class TablesController < ApplicationController
      rescue_from ActiveRecord::RecordNotFound, :with => :record_not_found

      def index
        guests = Guest.guest('created_at DESC');
        render json: {status: 'SUCCESS', message:'Loaded guests', data:guests},status: :ok
      end

      def show
        guest = Guest.find(params[:id])
        render json: {status: 'SUCCESS', message:'Loaded guest', data:guest},status: :ok
      end

      def create
        guest = Guest.new(guest_params)
        if guest.save
          render json: {status: 'SUCCESS', message:'Saved guest', data:guest},status: :ok
        else
          render json: {status: 'ERROR', message:'Guest not saved',
          data:guest.errors},status: :unprocessable_entity
        end
      end

      private

      def guest_params
        params.permit(:table_id, :number, :guest, :first_name, :last_name)
      end
    end
  end
end