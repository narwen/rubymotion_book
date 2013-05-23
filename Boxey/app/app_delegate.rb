class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.applicationFrame)
    @window.makeKeyAndVisible

    @blue_view = UIView.alloc.initWithFrame(CGRect.new([10,10], [100, 100]))
    @blue_view.backgroundColor = UIColor.blueColor

    @window.addSubview(@blue_view)

    @add_button = UIButton.buttonWithType(UIButtonTypeRoundedRect)
    @add_button.setTitle("Add", forState:UIControlStateNormal)
    @add_button.sizeToFit
    @add_button.frame = CGRect.new(
      [10, @window.frame.size.height - 10 - @add_button.frame.size.height],
      @add_button.frame.size)
    @window.addSubview(@add_button)

    @add_button.addTarget(self, action: "add_tapped", forControlEvents:UIControlEventTouchUpInside)

    @remove_button = UIButton.buttonWithType(UIButtonTypeRoundedRect)
    @remove_button.setTitle("Remove", forState:UIControlStateNormal)
    @remove_button.sizeToFit

    @remove_button.frame = CGRect.new(
      [@add_button.frame.origin.x + @add_button.frame.size.width + 10,
      @add_button.frame.origin.y],
      @remove_button.frame.size)
    @window.addSubview(@remove_button)
    @remove_button.addTarget(self, action: "remove_tapped",
                             forControlEvents:UIControlEventTouchUpInside)
    true
  end

  def add_tapped
    new_view = UIView.alloc.initWithFrame(CGRect.new([0, 0], [100, 100]))
    new_view.backgroundColor = UIColor.blueColor

    last_view = @window.subviews[0]
    new_view.frame = CGRect.new(
      [last_view.frame.origin.x, last_view.frame.origin.y + last_view.frame.size.height + 10],
      last_view.frame.size
    )
    @window.insertSubview(new_view, atIndex:0)
  end

  def remove_tapped
    other_views = @window.subviews.select do |view|
      not view.is_a? UIButton
    end

    @last_view = other_views.last

    if @last_view && other_views.count > 1
      UIView.animateWithDuration(0.5,
        animations: lambda {
        @last_view.alpha = 0
        @last_view.backgroundColor = UIColor.redColor
        other_views.each do |view|
          next if view == @last_view
          view.frame = CGRect.new([
            view.frame.origin.x,
            view.frame.origin.y - (@last_view.frame.size.height + 10)],
            view.frame.size)
        end
      },

      completion: lambda { |finished|
        @last_view.removeFromSuperview
      })
    end
  end
end
