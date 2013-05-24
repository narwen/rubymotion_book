class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.applicationFrame)
    @window.makeKeyAndVisible

    @blue_view = UIView.alloc.initWithFrame(CGRect.new([10,10], [100, 100]))
    @blue_view.backgroundColor = UIColor.blueColor

    @window.addSubview(@blue_view)
    add_labels_to_boxes

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

  def add_label_to_box(box)
    box.subviews.each do |subview|
      subview.removeFromSuperview
    end

    index_of_box = @window.subviews.index(box)
    label = UILabel.alloc.initWithFrame(CGRectZero)
    label.text = "#{index_of_box}"
    label.textColor = UIColor.whiteColor
    label.backgroundColor = UIColor.clearColor
    label.sizeToFit
    label.center = [box.frame.size.width / 2, box.frame.size.height / 2]
    box.addSubview(label)
  end

  def add_labels_to_boxes
    self.boxes.each do |box|
      add_label_to_box(box)
    end
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
    add_labels_to_boxes
  end

  def boxes
    @window.subviews.select do |view|
      not (view.is_a?(UIButton) or view.is_a?(UILabel))
    end
  end

  def remove_tapped
    other_views = self.boxes
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
      add_labels_to_boxes
    end
  end
end
