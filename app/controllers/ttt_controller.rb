class TttController < ApplicationController
  before_filter :verify_token

  def ingest
    render json: CommandDelegator.evaluate(params).to_hash
  end

  private
  def verify_token
    if !ActiveSupport::SecurityUtils.secure_compare(ENV['SLACK_TTT_COMMAND_TOKEN'], params[:token])
      render json: { text: "Error in token" }, status: 403
    end
  end
end
