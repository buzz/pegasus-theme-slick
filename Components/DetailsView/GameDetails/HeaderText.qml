import QtQuick 2.8
import QtQuick.Layouts 1.11

Rectangle {
  id: root
  property string titletext
  property var game

  color: "transparent"

  property real textWidth: {
    if (textMetrics.width > vpx(1220)) return vpx(1220);
    return textMetrics.width;
  }

  width: textWidth + vpx(20)
  height: parent.height
  clip: true

  Text {
    id: textMetrics
    font.capitalization: Font.AllUppercase
    font.family: headerFont.name
    font.pixelSize: vpx(48)
    text: titletext
    visible: false
  }

  Text {
    id: titleText
    color: "white"
    text: textMetrics.text
    font: textMetrics.font
    width: textWidth + vpx(20)

    Layout.maximumWidth: vpx(1120)
    elide: Text.ElideRight
  }
}
