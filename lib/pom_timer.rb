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

  def start
    countdown(@pom_time)
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
  attr_reader :pom_time, :break_time

  def initialize(pom_time = 25, break_time = 5)
    @pom_time = pom_time
    @break_time = break_time
  end

  def set_timers(args)
    if args.has_key?:pom_time
      @pom_time = args[:pom_time]
    end
    if args.has_key?:break_time
      @break_time = args[:break_time]
    end
  end

  def start_pom

  end
end
