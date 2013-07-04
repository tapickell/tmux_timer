require 'terminal-notifier'
require 'chronic_duration'

class CountdownTimer
  attr_reader :interval, :pom_time


  def initialize(time, name, emoji)
    @interval = 1
    @pom_time = time
    @name = name
    @emoji = emoji
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
    puts @emoji + " Time Left: " + data
    STDOUT.flush
  end

  def alert
    TerminalNotifier.notify("#{@name} Finished", title:"#{@name} Timer")
  end
end


class PomTimer
  attr_reader :pom_time, :break_time, :pom_countdown_timer, :break_countdown_timer

  POM_EMOJI = "\u{1f345} "
  BREAK_EMOJI = "\u{270b} "

  def initialize(pom_time = 25, break_time = 5)
    @pom_time = pom_time
    @break_time = break_time
    @pom_countdown_timer = CountdownTimer.new(@pom_time, "Pomodoro", POM_EMOJI)
    @break_countdown_timer = CountdownTimer.new(@break_time, "Break", BREAK_EMOJI)
  end

  def set_timers(args)
    @pom_time = args[:pom_time] if args.has_key?:pom_time
    @break_time = args[:break_time] if args.has_key?:break_time
  end

  def start_pom
    @pom_countdown_timer.start
  end

  def start_break
    @break_countdown_timer.start
  end

end

@pom_timer = PomTimer.new
@pom_timer.start_pom
@pom_timer.start_break
