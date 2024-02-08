class PlacesController < ApplicationController
  def destroy
    if current_user.admin_user?
      @place = Place.find(params[:id])
      @place.destroy
      redirect_to admin_place_index_path, flash: { success: t('flash.destroy', item: Place.model_name.human) }
    else
      redirect_to root_path, flash: { danger: t('flash.not_authorized') }
    end
  end
end
