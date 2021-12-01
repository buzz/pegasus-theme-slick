import QtQuick 2.15
import QtQuick.Layouts 1.11
import QtGraphicalEffects 1.15

Item {
  id: root

  required property string text
  required property string imageSource

  Image {
    id: icon

    height: root.height
    anchors {
      left: parent.left
      verticalCenter: root.verticalCenter
    }

    source: root.imageSource
    fillMode: Image.PreserveAspectFit
    smooth: true

    visible: false
  }

  ColorOverlay {
    anchors.fill: icon
    source: icon
    color: colorFontStrong
  }

  Text {
    id: text

    anchors {
      left: icon.right
      top: icon.top
      leftMargin: spacingHorizStd
    }

    text: root.text
    color: colorFontStrong
    font.family: headerFont.name
    font.pixelSize: fontSizeOptionsHeader
  }
}
