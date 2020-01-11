class AfterPartiesController < ApplicationController
  def show
  	@after_party = AfterParty.find(params[:event_id])
  end
end
