class Command
  attr_accessor :ctx

  def call(caller, args)
    raise NotImplementedException
  end

  def initialize(ctx)
    @ctx = ctx
  end
end
