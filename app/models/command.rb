class Command
  class CommandNotFound < StandardError; end

  attr_accessor :ctx

  def call(caller, args)
    raise NotImplementedException
  end

  def split_text(text)
    text.split(/\s+/)
  end

  def initialize(ctx)
    @ctx = ctx
  end
end

require 'commands/echo'
