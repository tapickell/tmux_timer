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
