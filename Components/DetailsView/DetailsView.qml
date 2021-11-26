import QtQuick 2.8
import QtGraphicalEffects 1.12
import "GameGrid"
import "GameDetails"

FocusScope {
  id: detailsView

  property var currentCollection
  property alias currentGameIndex: grid.currentGameIndex
  property bool zoomSelectedItem: true
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
      delaySelectedZoom();
      return;
    }
    if (api.keys.isPrevPage(event)) {
      event.accepted = true;
      prevCollection();
      delaySelectedZoom();
      return;
    }
  }

  // Prevent initial animation glitch on selected item
  function delaySelectedZoom() {
    zoomSelectedItem = false;
    timerSelectedZoom.restart();
  }

  Timer {
    id: timerSelectedZoom
    interval: 100
    onTriggered: zoomSelectedItem = true
  }

  // Background
  Rectangle {
    color: colorBg
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
