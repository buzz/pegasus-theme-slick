import QtQuick 2.15

import "GameDetails"
import "GameGrid"

FocusScope {
  id: gamelistScreen

  property var collection

  property alias currentGameIndex: grid.currentGameIndex

  signal itemSelected(int gameIndex)
  signal back

  onCollectionChanged:  Qt.callLater(resetSelected)
  onFocusChanged: focus && Qt.callLater(resetSelected)

  function resetSelected() {
    if (gamelistScreen.collection)
      grid.resetSelectedItem(restoreGameIndex(gamelistScreen.collection.shortName));
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
