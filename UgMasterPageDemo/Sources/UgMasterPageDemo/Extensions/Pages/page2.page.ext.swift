import ScadeKit

extension Page1PageAdapter {
  var label2: SCDWidgetsLabel {
    return self.page?.getWidgetByName("label1") as! SCDWidgetsLabel
  }
}