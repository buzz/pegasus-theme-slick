import QtQuick 2.15

ListView {
  readonly property int velocity: orientation === ListView.Vertical ? vpx(1280 * 3) : vpx(1280 * 4)

  orientation: ListView.Horizontal
  reuseItems: true
  snapMode: PathView.SnapOneItem
  highlightRangeMode: ListView.StrictlyEnforceRange
  keyNavigationEnabled: false
  highlightFollowsCurrentItem: true
  spacing: vpx(100)
  cacheBuffer: 0 // Keep 1 delegate outside of screen in each direction

  highlightMoveDuration: -1
  highlightMoveVelocity: velocity
  maximumFlickVelocity: velocity

  model: api.collections

  Component.onCompleted: {
    // console.log("CollectionsCarousel:onCompleted restored=", restoredCollectionIndex);
    positionViewAtIndex(restoredCollectionIndex, ListView.SnapPosition);
    currentIndex = restoredCollectionIndex;
  }

  delegate: CollectionScreen {
    width: main.width
    height: main.height
  }
}
