class Api::V1::CountriesController < ApplicationController
  before_action :set_country, only: [:show, :update, :destroy, :extra]

  # GET /countries
  def index
    @countries = Country.all

    render json: @countries, each_serializer: CountryIndexSerializer
  end

  # GET /countries/1
  def show
    render json: @country
  end

  # POST /countries
  def create
    @country = Country.new(country_params)

    if @country.save
      render json: @country, status: :created, location: @country
    else
      render json: @country.errors, status: :unprocessable_entity
    end
  end

  def extra
    @extra = Country.find_by(name: params[:extra])
    @info = @country.relationship(@extra)
    render json: @info, each_serializer: CountryExtraSerializer
  end
  # PATCH/PUT /countries/1
  def update
    if @country.update(country_params)
      render json: @country
    else
      render json: @country.errors, status: :unprocessable_entity
    end
  end

  # DELETE /countries/1
  def destroy
    @country.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_country
      @country = Country.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def country_params
      params.require(:country).permit(:name, :high_income, :upper_middle_income, :middle_income, :lower_middle_income, :low_income)
    end
end
