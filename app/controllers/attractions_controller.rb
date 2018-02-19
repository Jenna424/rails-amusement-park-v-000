class AttractionsController < ApplicationController
  before_action :set_attraction, only: [:show, :edit, :update, :destroy]
# filter method #set_attraction will be called before the actions above
  def new # implicitly renders app/views/attractions/new.html.erb (form to create new attraction)
    @attraction = Attraction.new # @attraction is instance for form_for to wrap around
  end

  def create
    @attraction = Attraction.new(attraction_params)
    respond_to do |format|
      if @attraction.save
        format.html { redirect_to attraction_path(@attraction), notice: 'Attraction was successfully created.' }
      else
        flash.now[:error] = "Your attempt to create an attraction was unsuccessful. Please try again."
        format.html { render :new }
      end
    end
  end

  def edit # implicitly renders app/views/attractions/edit.html.erb (form to edit attraction)
  end

  def update
    respond_to do |format|
      if @attraction.update(attraction_params)
        format.html { redirect_to attraction_path(@attraction), notice: 'Attraction was successfully updated.' }
      else
        flash.now[:error] = "Your attempt to edit the attraction was unsuccessful. Please try again."
        format.html { render :edit }
      end
    end
  end

  def index # implicitly renders app/views/attractions/index.html.erb (index of all attractions)
    @attractions = Attraction.all # @attractions stores 'array' of all attraction instances
  end

  def show
    @ride = Ride.new
  end

  def destroy
    @attraction.destroy
    respond_to do |format|
      format.html { redirect_to attractions_url, notice: 'Attraction was successfully deleted.' }
    end
  end

  private

    def set_attraction
      @attraction = Attraction.find(params[:id])
    end

    def attraction_params # private method returns sanitized, strong params
      params.require(:attraction).permit(
        :name,
        :tickets,
        :min_height,
        :happiness_rating,
        :nausea_rating
      )
    end
end
