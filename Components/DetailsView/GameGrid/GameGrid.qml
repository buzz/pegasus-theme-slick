import QtQuick 2.8
import "../utils.js" as Utils // some helper functions

Rectangle {
  property alias currentGameIndex: gridView.currentIndex

  color: "transparent"

  GridView {
    id: gridView

    preferredHighlightBegin: vpx(120)
    preferredHighlightEnd: root.height - vpx(220)

    anchors {
      fill: parent
      rightMargin: vpx(40)
      leftMargin: vpx(36)
    }

    property bool firstImageLoaded: false
    property real cellHeightRatio: 0.5

    function cellsNeedRecalc() {
      firstImageLoaded = false;
      cellHeightRatio = 0.5;
    }

    focus: true
    snapMode: GridView.SnapToRow
    highlightFollowsCurrentItem: true
    highlightRangeMode: GridView.StrictlyEnforceRange

    model: currentCollection.games
    onModelChanged: cellsNeedRecalc()
    onCountChanged: cellsNeedRecalc()

    property real columnCount: {
      if (cellHeightRatio > 1.2) return 5;
      if (cellHeightRatio > 0.6) return 4;
      return 3;
    }

    function calcHeightRatio(imageW, imageH) {
      cellHeightRatio = 0.5;

      if (imageW > 0 && imageH > 0)
        cellHeightRatio = imageH / imageW;
    }

    cellWidth: width / columnCount
    cellHeight: cellWidth * cellHeightRatio;

    displayMarginBeginning: anchors.topMargin

    delegate: GameGridItem {
      width: GridView.view.cellWidth
      height: GridView.view.cellHeight
      selected: GridView.isCurrentItem
      systemColor: Utils.systemColor(currentCollection.shortName)

      game: modelData

      imageHeightRatio: {
        if (gridView.firstImageLoaded) return gridView.cellHeightRatio;
        return 0.5;
      }
      onImageLoaded: {
        // NOTE: because images are loaded asynchronously,
        // firstImageLoaded may appear false multiple times!
        if (!gridView.firstImageLoaded) {
          gridView.firstImageLoaded = true;
          gridView.calcHeightRatio(imageWidth, imageHeight);
        }
      }
    }
  }
}
