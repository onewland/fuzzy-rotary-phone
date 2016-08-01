class PingController < ApplicationController
  def show
    render json: params.to_json
  end
end
