import QtQuick 2.8
import QtGraphicalEffects 1.12

Item {
  id: gridItem
  height: width * imageHeightRatio
  z: 1

  property var game
  property int columnCount

  property alias imageWidth: imageBoxArt.paintedWidth
  property alias imageHeight: imageBoxArt.paintedHeight
  property bool imageLoading: imageBoxArt.status === Image.Loading
  property real imageHeightRatio: 0.5

  signal clicked()
  signal doubleClicked()
  signal imageLoaded(int imgWidth, int imgHeight)

  readonly property int tilePadding: 4

  readonly property bool firstColumn: index % columnCount === 0
  readonly property bool lastColumn: index % columnCount === columnCount - 1

  // Keep outmost left/right items within grid bounds
  property real translateX: {
    if (index % columnCount === 0) {
      return (width - tilePadding) / 2 - 24; // First column
    }
    if (index % columnCount === columnCount - 1) {
      return - (width - tilePadding) / 2 + 24; // Last column
    }
    return 0;
  }

  transform: Translate {
    id: translation
    x: 0
  }

  states: [
    State {
      name: "selected"
      PropertyChanges {
        target: gridItem
        z: 3
      }
      PropertyChanges {
        target: translation
        x: vpx(gridItem.translateX)
      }
      PropertyChanges {
        target: boxArt
        scale: 1
        layer.enabled: true
      }
    }
  ]

  transitions: Transition {
    PropertyAnimation {
      target: gridItem
      property: "z"
      duration: durationShort
    }
    PropertyAnimation {
      target: translation
      property: "x"
      duration: durationShort
      easing.type: Easing.InOutCubic
    }
    PropertyAnimation {
      target: boxArt
      property: "scale"
      duration: durationShort
      easing.type: Easing.InOutCubic
    }
  }

  // Box art image (non-selected are scaled down, so zoomed-in picture are crisp)
  Rectangle {
    id: boxArt
    width: parent.width * boxArtScaleFactor
    height: parent.height * boxArtScaleFactor
    transform: Translate {
      x: - width
      y: - height
    }

    color: "transparent"

    scale: 1 / boxArtScaleFactor

    layer.enabled: false
    layer.effect: DropShadow {
      spread: 0.15
      horizontalOffset: 0
      verticalOffset: 0
      radius: vpx(18)
      samples: 37
      color:  "black"
      transparentBorder: true
    }

    Image {
      id: imageBoxArt
      anchors {
        fill: parent
        margins: vpx(tilePadding)
      }

      asynchronous: true
      visible: game.assets.boxFront

      source: game.assets.boxFront || ""
      sourceSize { width: 512; height: 512 }
      fillMode: Image.PreserveAspectFit
      smooth: true

      onStatusChanged: {
        if (status === Image.Ready) {
          imageHeightRatio = paintedHeight / paintedWidth;
          gridItem.imageLoaded(paintedWidth, paintedHeight);
        }
      }
    }

    // Missing box art fallback: Show dummy box art with game title
    Rectangle {
      anchors {
        fill: parent
        margins: vpx(tilePadding)
      }
      border {
        width: vpx(8)
        color: colorBoxBorder
      }
      color: colorBgBox
      visible: !game.assets.boxFront

      Item {
        anchors.fill: parent

        Text {
          anchors.fill: parent
          text: "?"
          font {
            pixelSize: vpx(9999)
            family: subheaderFont.name
          }
          color: "#777"
          fontSizeMode: Text.Fit
          horizontalAlignment: Text.AlignHCenter
          verticalAlignment: Text.AlignVCenter
        }

        Text {
          anchors {
            fill: parent
            margins: vpx(16)
          }
          text: game.title
          wrapMode: Text.WrapAnywhere
          horizontalAlignment: Text.AlignHCenter
          verticalAlignment: Text.AlignVCenter
          color: colorFontBox
          font {
            pixelSize: vpx(48)
            family: headerFont.name
          }
        }
      }
    }

    // Loading spinner
    Item {
      visible: imageLoading
      anchors {
        fill: parent
        margins: vpx(tilePadding)
      }

      Rectangle {
        width: imageBoxArt.width
        height: imageBoxArt.height
        color: "black"
        anchors.fill: parent
      }

      Image {
        anchors.centerIn: parent

        source: "../../../assets/loading-spinner.png"

        RotationAnimator on rotation {
          loops: Animator.Infinite;
          from: 0;
          to: 360;
          duration: durationLoadingSpinner
        }
      }
    }
  }

  MouseArea {
    anchors.fill: parent
    onClicked: gridItem.clicked()
    onDoubleClicked: gridItem.doubleClicked()
  }
}
