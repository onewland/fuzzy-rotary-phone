class TttController < ApplicationController
  before_filter :verify_token

  def ingest
    begin
      render json: CommandDelegator.evaluate(params).to_hash
    rescue CommandDelegator::CommandNotFound
      render json: { text: "That command not recognized. Try /ttt help for help" }
    end
  end

  private
  def verify_token
    if !ActiveSupport::SecurityUtils.secure_compare(ENV['SLACK_TTT_COMMAND_TOKEN'], params[:token])
      render json: { text: "Error in token" }, status: 403
    end
  end
end
