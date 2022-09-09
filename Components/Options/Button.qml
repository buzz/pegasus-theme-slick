import QtQuick 2.12

FocusScope {
  id: root

  required property string text

  signal activate

  Rectangle {
    color: root.focus ? colorControlBgHighlight : "transparent"
    radius: radiusSmall

    anchors.centerIn: parent
    width: buttonText.implicitWidth + spacingHorizStd * 2
    height: buttonText.implicitHeight + spacingVertStd

    Behavior on color {
      PropertyAnimation {
        duration: durationShort
        easing.type: Easing.OutQuad
      }
    }

    Text {
      id: buttonText

      focus: true
      anchors.centerIn: parent

      text: root.text
      color: root.focus || mouseArea.containsMouse ? colorFontOptionsSelected : colorFontOptions
      font.family: generalFont.name
      font.pixelSize: fontSizeOptions

      Behavior on color {
        PropertyAnimation {
          duration: durationShort
          easing.type: Easing.OutQuad
        }
      }

      Keys.onPressed: {
        if (api.keys.isAccept(event)) {
          event.accepted = true;
          activate();
        }
      }
    }
  }

  MouseArea {
    id: mouseArea

    anchors.fill: parent
    hoverEnabled: true

    onClicked: activate()
  }
}
