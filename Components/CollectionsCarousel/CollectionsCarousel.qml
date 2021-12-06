import QtQuick 2.15
import "../utils.js" as Utils

ListView {
  function jumpTo() {
    if (currentCollectionIndex >= 0) {
      positionViewAtIndex(currentCollectionIndex, ListView.SnapPosition);
      currentIndex = currentCollectionIndex;
    }
  }

  Keys.onPressed: {
    if (api.keys.isAccept(event)) {
      event.accepted = true;

      const collection = collectionSearchFilter.get(currentCollectionIndex);
      if (collection && collection.games && collection.games.count) {
        Utils.saveCollectionIndex();
        gamelistScreen.focus = true;
      }
    }
  }
  Keys.onRightPressed: {
    if (!horizontalVelocity) {
      event.accepted = true;
      incrementCurrentIndex();
    }
  }
  Keys.onLeftPressed: {
    if (!horizontalVelocity) {
      event.accepted = true;
      decrementCurrentIndex();
    }
  }

  onCurrentIndexChanged: currentCollectionIndex = currentIndex

  currentIndex: -1
  model: collectionSearchFilter

  orientation: ListView.Horizontal
  snapMode: PathView.SnapOneItem
  highlightRangeMode: ListView.StrictlyEnforceRange
  keyNavigationEnabled: false
  highlightFollowsCurrentItem: true
  spacing: vpx(100)
  cacheBuffer: 0 // Keep 1 delegate outside of screen in each direction
  reuseItems: true

  highlightMoveDuration: -1
  highlightMoveVelocity: vpx(1280 * 4)
  maximumFlickVelocity: highlightMoveVelocity

  delegate: CollectionScreen {
    width: main.width
    height: main.height
  }

  Text {
    anchors.centerIn: parent

    color: colorFontStrong
    font.family: generalFont.name
    font.pixelSize: fontSizeCollectionSubheader
    text: "No collections found…"
    visible: currentCollectionIndex === -1
  }
}
