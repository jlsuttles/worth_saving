class DraftsController < ApplicationController
  def create
    @draft = Draft.find_or_initialize_by_record_type_and_record_id(params[:draft])
    @draft.attributes = params[:draft]
    if @draft.save
    else
      render :status => 500
    end
  end
  
  def destroy
    @draft = Draft.find_by_id(params[:id])
    if !@draft.nil?
      @draft.destroy 
    else
      render :status => 404
    end
  end

end
