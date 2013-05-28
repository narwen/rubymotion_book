class ColorDetailController < UIViewController
  def initWithColor(color)
    self.initWithNibName(nil, bundle: nil)
    @color = color
    self
  end

  def viewDidLoad
    super

    self.view.backgroundColor = @color
    self.title = 'Detail'
  end
end
