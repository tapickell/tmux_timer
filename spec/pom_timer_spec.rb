require "pom_timer"

describe CountdownTimer do
  before(:each) do
    @countdown_timer = CountdownTimer.new(25, "Pomodoro")
  end

  it "should init with interval of 1" do
    @countdown_timer.interval.should == 1
  end

  describe "#start" do
    before(:each) do
      @countdown_timer = CountdownTimer.new(25, "Pomodoro")
    end

    it "should call countdown with minutes for pom" do
      @countdown_timer.should_receive(:countdown).with(25)
      @countdown_timer.start
    end
  end
  describe "#countdown" do
    before(:each) do
      @countdown_timer = CountdownTimer.new(25, "Pomodoro")
    end

    it "should call output method" do
      @countdown_timer.should_receive(:output).at_least(1).times
      @countdown_timer.countdown(25)
    end

    it "should call alert at end of countdown" do
      @countdown_timer.should_receive(:alert)
      @countdown_timer.countdown(25)
    end
  end

  describe "#duration" do
    before(:each) do
      @countdown_timer = CountdownTimer.new(25, "Pomodoro")
    end

    it "should return time in min sec format when passed seconds" do
      @countdown_timer.duration(90).should == "1m 30s"
    end
  end

  describe "#output" do
    before(:each) do
      @countdown_timer = CountdownTimer.new(25, "Pomodoro")
    end

    it "should pass formatted data to stdout" do
      STDOUT.should_receive(:puts).with("Time Left: 1m 30s")
      @countdown_timer.output("1m 30s")
    end

    it "should call flush on stdout" do
      STDOUT.should_receive(:flush)
      @countdown_timer.output("1m 30s")
    end
  end

  describe "#alert" do
    before(:each) do
      @countdown_timer = CountdownTimer.new(25, "Pomodoro")
    end

    it "should call notify on terminal notifier" do
      TerminalNotifier.should_receive(:notify).with("Pomodoro Finished", {:title => "Pomodoro Timer"})
      @countdown_timer.alert
    end
  end
end

describe PomTimer do
  before(:each) do
    @pom_timer = PomTimer.new
  end

  it "should init with pom_time setting of 25 min" do
    @pom_timer.pom_time.should == 25
  end

  it "should init with break_time setting of 5 min" do
    @pom_timer.break_time.should == 5
  end

  describe "#set_timers" do
    before(:each) do
      @pom_timer = PomTimer.new
    end

    it "should change the pom time to passed in value" do
      expect{@pom_timer.set_timers({:pom_time => 20})}.to change{@pom_timer.pom_time}.by(-5)
    end

    it "should change the break time to passed in value" do
      expect{@pom_timer.set_timers({:break_time  => 7})}.to change{@pom_timer.break_time}.by(2)
    end
  end

  describe "#start_pom" do
    before(:each) do
      @pom_timer = PomTimer.new
    end

    it "should create a new timer with pom_time setting" do
      @pom_timer.start_pom
    end
  end
end


__END__

start timer service
  end timer service
  check for running service
  start pom
  check status
  pause pom
  cancel pom
  change pom settings

  needs call back from CountdownTimer to calling class
