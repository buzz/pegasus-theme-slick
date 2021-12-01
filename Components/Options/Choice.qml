import QtQuick 2.15
import QtGraphicalEffects 1.12

FocusScope {
  id: root

  clip: true

  required property var model
  readonly property int itemWidth: vpx(90)

  property alias currentIndex: listView.currentIndex

  signal accept

  // Smoothly fade out grid at top and bottom
  LinearGradient {
    id: gradientMask
    anchors.fill: parent

    visible: false
    start: Qt.point(0, 0)
    end: Qt.point(width, 0)
    gradient: Gradient {
      GradientStop { position: 0.0; color: "transparent"}
      GradientStop { position: 0.1; color: "#ffffffff" }
      GradientStop { position: 0.5; color: "#ffffffff" }
      GradientStop { position: 0.9; color: "#ffffffff" }
      GradientStop { position: 1.0; color: "transparent"}
    }
  }

  ListView {
    id: listView

    anchors.fill: parent

    focus: true

    orientation: ListView.Horizontal
    snapMode: PathView.SnapOneItem
    highlightRangeMode: ListView.StrictlyEnforceRange
    highlightFollowsCurrentItem: true
    keyNavigationEnabled: false
    preferredHighlightBegin: (parent.width - itemWidth) / 2
    preferredHighlightEnd: (parent.width + itemWidth) / 2
    highlightMoveDuration: -1
    highlightMoveVelocity: vpx(200 * 4)
    maximumFlickVelocity: highlightMoveVelocity
    spacing: spacingStd / 2

    model: root.model

    layer.enabled: true
    layer.effect: OpacityMask {
      maskSource: gradientMask
    }

    delegate: Item {
      id: choiceItem

      width: itemWidth
      height: rect.height

      property int choiceItemIndex: index

      Rectangle {
        id: rect

        color: root.focus && choiceItem.ListView.isCurrentItem ? colorControlBgHighlight : "transparent"
        radius: radiusSmall
        width: itemWidth
        height: text.implicitHeight + spacingVertStd
        anchors.centerIn: parent

        Behavior on color {
          PropertyAnimation {
            duration: durationShort
            easing.type: Easing.OutQuad
          }
        }

        Text {
          id: text

          anchors.centerIn: parent
          font.family: generalFont.name
          font.pixelSize: fontSizeOptions
          text: name
          horizontalAlignment: Text.AlignHCenter
          color: choiceItem.ListView.isCurrentItem || mouseArea.containsMouse ? colorFontOptionsSelected : colorFontOptions

          Behavior on color {
            PropertyAnimation {
              duration: durationShort
              easing.type: Easing.OutQuad
            }
          }
        }
      }

      MouseArea {
        id: mouseArea

        anchors.fill: parent
        hoverEnabled: true
        onClicked: {
          listView.currentIndex = index;
          root.focus = true;
        }
      }
    }

    Keys.onPressed: {
      if (api.keys.isAccept(event)) {
        event.accepted = true;
        accept();
      }
    }
    Keys.onRightPressed: {
      event.accepted = true;
      listView.incrementCurrentIndex();
    }
    Keys.onLeftPressed: {
      event.accepted = true;
      listView.decrementCurrentIndex();
    }
  }
}
