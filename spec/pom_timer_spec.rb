require "pom_timer"

describe PomTimer do
  before(:each) do
    @pom_timer = PomTimer.new
  end

  it "should init with interval of 1" do
    @pom_timer.interval.should == 1
  end

  describe "#countdown" do
    before(:each) do
      @pom_timer = PomTimer.new
    end

    it "should set timer to seconds value of minutes passed in" do
      @pom_timer.countdown(25)
      @pom_timer.pom_time.should == (25 * 60)
    end

    it "should call output method" do
      @pom_timer.should_receive(:output).at_least(1).times
      @pom_timer.countdown(25)
    end

    it "should call alert at end of countdown" do
      @pom_timer.should_receive(:alert)
      @pom_timer.countdown(25)
    end
  end

  describe "#duration" do
    before(:each) do
      @pom_timer = PomTimer.new
    end

    it "should return time in min sec format when passed seconds" do
      @pom_timer.duration(90).should == "1m 30s"
    end
  end

  describe "#output" do
    before(:each) do
      @pom_timer = PomTimer.new
    end

    it "should pass formatted data to stdout" do
      STDOUT.should_receive(:puts).with("Time Left: 1m 30s")
      @pom_timer.output("1m 30s")
    end

    it "should call flush on stdout" do
      STDOUT.should_receive(:flush)
      @pom_timer.output("1m 30s")
    end
  end

  describe "#alert" do
    before(:each) do
      @pom_timer = PomTimer.new
    end

    it "should call notify on terminal notifier" do
      TerminalNotifier.should_receive(:notify).with("Finished", {:title => "PomTimer"})
      @pom_timer.alert
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
