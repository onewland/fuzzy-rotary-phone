class PingController < ApplicationController
  def show
    render json: {"text" => params.to_json}
  end
end
