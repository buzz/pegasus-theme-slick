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
  clip: true

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

  // Background
  Rectangle {
    color: "#0c0c0c"
    anchors.fill: parent
  }

  GameDetails {
    id: gameDetails
    width: parent.width / 2.2

    anchors {
      top: parent.top
      left: parent.left
      bottom: parent.bottom
    }
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
}
