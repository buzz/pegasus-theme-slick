import QtQuick 2.15
import QtQuick.Layouts 1.11

Rectangle {
  id: root
  property string metaTitle
  property string metaContent
  width: vpx(66)
  height: vpx(66)
  color: "transparent"

  RowLayout {
    id: rowcontent
    anchors.verticalCenter: root.verticalCenter
    anchors.horizontalCenter: root.horizontalCenter
    Rectangle {
      id: metaBox
      width: root.width
      height: root.height
      color: colorBgMetaBox
      clip: true

      Text {
        text: metaTitle
        color: colorFontBox
        width: parent.width
        font.family: generalFont.name
        fontSizeMode: Text.Fit
        font.pixelSize: spacingStd
        font.weight: Font.Bold
        font.capitalization: Font.AllUppercase
        horizontalAlignment: Text.AlignHCenter
        padding: vpx(4)
        anchors {
          bottom: parent.bottom;
          left: parent.left
          right: parent.right
        }
      }

      Text {
        id: metaValue
        text: metaContent
        color: colorFontBoxValue
        width: parent.width
        height: parent.height
        font.family: headerFont.name
        font.weight: Font.Bold
        font.capitalization: Font.AllUppercase
        fontSizeMode: Text.Fit
        font.pixelSize: vpx(44)
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        leftPadding: vpx(3)
        rightPadding: vpx(3)
        bottomPadding: vpx(12)
        topPadding: vpx(6)
        wrapMode: Text.WordWrap
        maximumLineCount: 3
        lineHeight: 0.8
      }
    }
  }
}
