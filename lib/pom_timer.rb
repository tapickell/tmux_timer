require 'terminal-notifier'
require 'chronic_duration'

class CountdownTimer
  attr_reader :interval, :pom_time

  def initialize(time, name)
    @interval = 1
    @pom_time = time
    @name = name
  end

  def countdown(time)
    time_left = time * 60
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
    TerminalNotifier.notify("#{@name} Finished", title:"#{@name} Timer")
  end
end


class PomTimer

end
