module Api
  module V1
    class GuestsController < ApplicationController
      
      def index
        guests = Guest.guest('created_at DESC');
        render json: {status: 'SUCCESS', message:'Loaded guests', data:guests},status: :ok
      end

      def show
        guest = Guest.find(params[:id])
        render json: {status: 'SUCCESS', message:'Loaded guest', data:guest},status: :ok
      end

      def create
        guest = Guest.new(order_params)

        if guest.save
          render json: {status: 'SUCCESS', message:'Saved guest', data:guest},status: :ok
        else
          render json: {status: 'ERROR', message:'Guest not saved',
          data:guest.errors},status: :unprocessable_entity
        end
      end

      private

      def order_params
        params.permit(:guest, :first_name, :last_name, :gender, :firstname, :lastname, :fb_profile_pic, :fb_id, :profilepicurl, :messengeruserid, :chatfueluserid)
      end

    end
  end
end