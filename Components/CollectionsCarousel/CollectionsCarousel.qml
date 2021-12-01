import QtQuick 2.15

ListView {
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

  Component.onCompleted: {
    model = collectionSearchFilter;
    positionViewAtIndex(restoredCollectionIndex, ListView.SnapPosition);
    currentIndex = restoredCollectionIndex;
  }

  delegate: CollectionScreen {
    width: main.width
    height: main.height
  }
}
