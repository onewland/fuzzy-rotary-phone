class CommandResponse
  attr_accessor :response_type, :text

  def initialize(response_type: 'ephemeral', text:)
    @response_type = response_type
    @text = text
  end

  def to_hash
    { response_type: @response_type, text: @text }
  end
end
