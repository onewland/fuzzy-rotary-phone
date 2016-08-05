require 'command'

class CommandDelegator
  class CommandNotFound < StandardError; end

  COMMANDS = {
    'echo' => Commands::Echo
  }

  def self.split_text(text)
    text.split(/\s+/).select(&:present?)
  end

  def self.evaluate(slack_params)
    text = slack_params[:text]
    arg_stack = split_text(text)
    cmd = arg_stack.shift
    slack_params[:remaining_args] = arg_stack
    call_command(cmd, slack_params)
  end

  def self.call_command(name, params)
    command = COMMANDS[name]
    if command
      command.new(params).execute
    else
      raise CommandNotFound.new(name)
    end
  end
end
