import QtQuick 2.15

import "GameDetails"
import "GameGrid"

FocusScope {
  id: gamelistScreen

  property var collection

  signal itemSelected(int gameIndex)
  signal back

  onCollectionChanged: {
    console.log("GamelistScreen:onCollectionChanged", collection);
    resetSelected(collection);
  }

  onFocusChanged: {
    console.log("GamelistScreen:onFocusChanged");
    if (focus)
      resetSelected(collection);
  }

  function resetSelected(collection) {
    grid.resetSelectedItem(collection && restoreGameIndex(collection.shortName));
  }

  function getCurrentGameIndex() {
    return grid.currentGameIndex;
  }

  GameDetails {
    id: gameDetails

    game: collection.games.get(grid.currentGameIndex)

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
