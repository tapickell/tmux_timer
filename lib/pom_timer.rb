require 'terminal-notifier'
require 'chronic_duration'

class PomTimer
  attr_reader :interval, :pom_time

  def initialize
    @interval = 1
  end

  def countdown(time)
    time_left = @pom_time = time * 60
    while time_left > 0
      output(duration(time_left))
      time_left -= @interval
    end
    alert
  end

  def duration(seconds)
    ChronicDuration::output(seconds, :format => :short)
  end

  def output(data)
    puts "Time Left: " + data
    STDOUT.flush
  end

  def alert
    TerminalNotifier.notify("Finished", title:"PomTimer")
  end
end
