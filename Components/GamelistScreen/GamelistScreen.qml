import QtQuick 2.15

import "GameDetails"
import "GameGrid"

FocusScope {
  id: gamelistScreen

  property var collection

  signal itemSelected()
  signal back

  function jumpToCollection() {
    collection = collectionSearchFilter.get(currentCollectionIndex)
    gameGrid.jumpToCollection();
  }

  function jumpToGame() {
    const game = gamelistSearchFilter.get(currentGameIndex);
    gameDetails.game = game;
    Qt.callLater(gameGrid.jumpToGame);
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
    id: gameGrid

    optionsView: mainSwitcher.optionsView

    width: parent.width / 2
    anchors {
      top: parent.top
      right: parent.right
      bottom: parent.bottom
    }
  }
}
