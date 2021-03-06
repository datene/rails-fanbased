class VenuesController < ApplicationController
  def index
    # @bars = current_user.bar
    @venues = Venue.all
  end

  def new
    @venue = Venue.new
  end

  def create
    @venue = Venue.new(venue_params)
    # @venue.user = current_user
    if @venue.save
      redirect_to venue_path(@venue.id)
    else
      render :new
    end
  end

  def show
    # if current_user.owns_bar?(Bar.find(params[:id]))
    @venue = Venue.find(params[:id])
    @attendee = Attendee.new
    @alert_message = "You are viewing #{@venue.name}"
    @venue_coordinates = { lat: @venue.latitude, lng: @venue.longitude }
    @venues = Venue.where.not(latitude: nil, longitude: nil)
    @hash = Gmaps4rails.build_markers(@venue) do |venue, marker|
      marker.lat venue.latitude
      marker.lng venue.longitude
    end
  end

      def edit
        @venue = Venue.find(params[:id])
      end

      def update
        @venue = Venue.find(params[:id])
        @venue.update(venue_params)
        @venue.save
        redirect_to venues_path(@venue)
      end

      def destroy
        @venue = Venue.find(params[:id]).destroy
        redirect_to venue_path
      end

      private

      def venue_params
        params.require(:venue).permit(:name, :address, :description, :rating, :close, :screens, :internet, :food, :price_range, :photo, :photo_cache)
      end
    end



