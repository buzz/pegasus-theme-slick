import QtQuick 2.15
import QtQuick.Controls 2.15

FocusScope {
  id: root

  property alias searchText: searchInput.text

  height: searchInput.height + spacingVertStd * 2
  clip: true

  signal accept()

  Rectangle {
    id: rect

    anchors.fill: parent

    color: root.focus ? colorControlBgHighlight : colorTextInputBg
    radius: radiusSmall

    Behavior on color {
      PropertyAnimation {
        duration: durationShort
        easing.type: Easing.OutQuad
      }
    }

    TextInput {
      id: searchInput

      anchors {
        top: parent.top
        left: parent.left
        right: parent.right
        topMargin: spacingVertStd
        rightMargin: spacingHorizStd
        leftMargin: spacingHorizStd
      }
      focus: true

      color: focus ? colorFontOptionsSelected : colorFontOptions
      font.family: generalFont.name
      font.pixelSize: fontSizeOptions
      maximumLength: 60

      onAccepted: root.accept()
    }
  }
}
