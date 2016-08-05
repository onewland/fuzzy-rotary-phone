module Commands
  class Echo < Command
    def execute
      ::CommandResponse.new(text: ctx.inspect)
    end
  end
end
