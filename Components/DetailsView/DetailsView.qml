import QtQuick 2.8
import QtGraphicalEffects 1.12
import "GameGrid"
import "GameDetails"

FocusScope {
  id: root

  property var currentCollection
  property alias currentGameIndex: grid.currentGameIndex
  readonly property var currentGame: currentCollection.games.get(currentGameIndex)

  width: parent.width
  height: parent.height
  enabled: focus
  visible: y + height >= 0

  signal cancel
  signal nextCollection
  signal prevCollection
  signal launchGame

  Keys.onPressed: {
    if (event.isAutoRepeat)
      return;

    if (api.keys.isAccept(event)) {
      event.accepted = true;
      launchGame();
      return;
    }
    if (api.keys.isCancel(event)) {
      event.accepted = true;
      cancel();
      return;
    }
    if (api.keys.isNextPage(event)) {
      event.accepted = true;
      nextCollection();
      return;
    }
    if (api.keys.isPrevPage(event)) {
      event.accepted = true;
      prevCollection();
      return;
    }
  }

  Rectangle {
    color: "#0c0c0c"
    anchors.fill: parent
  }

  GameGrid {
    id: grid
    width: parent.width / 2
    anchors {
      top: parent.top
      right: parent.right
      bottom: parent.bottom
    }
  }

  // Subtle gradient over the bottom of the grid
  LinearGradient {
    anchors {
      fill: parent
      topMargin: vpx(360)
    }
    start: Qt.point(0, 0)
    end: Qt.point(0, height)
    gradient: Gradient {
      GradientStop { position: 0.0; color: "#000c0c0c" }
      GradientStop { position: 0.7; color: "#dd0c0c0c" }
      GradientStop { position: 1.0; color: "#ff0c0c0c" }
    }
    cached: true
  }

  GameDetails {
    width: parent.width / 2

    anchors {
      top: parent.top
      left: parent.left
      bottom: parent.bottom
    }
  }
}
