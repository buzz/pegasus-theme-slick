import QtQuick 2.15
import QtGraphicalEffects 1.12

Item {
  id: gameGrid

  property alias currentGameIndex: gridView.currentIndex

  property bool zoomSelectedItem: false

  function resetSelectedItem(idx) {
    zoomSelectedItem = false;
    resetSelectedTimer.restart();

    if (idx !== undefined) {
      gridView.positionViewAtIndex(idx, ListView.SnapPosition)
      gridView.currentIndex = idx;
    }
  }

  Timer {
    id: resetSelectedTimer

    interval: 50
    onTriggered: zoomSelectedItem = true
  }

  // Smoothly fade out grid at top and bottom
  LinearGradient {
    id: gradientMask
    anchors.fill: parent
    visible: false
    gradient: Gradient {
      GradientStop { position: 0.01; color: "transparent"}
      GradientStop { position: 0.04; color: "#55ffffff"}
      GradientStop { position: 0.1; color: "#ffffffff" }
      GradientStop { position: 0.75; color: "#ffffffff" }
      GradientStop { position: 0.99; color: "transparent"}
    }
  }

  // Opacity mask needs to overlap grid as selected item may stick out of grid
  // and would be clipped.
  Item {
    anchors.fill: parent

    layer.enabled: true
    layer.effect: OpacityMask {
      maskSource: gradientMask
    }

    GridView {
      id: gridView

      property bool firstImageLoaded: false
      property real cellHeightRatio: 0.5

      focus: true

      anchors {
        fill: parent
        rightMargin: vpx(40)
        leftMargin: vpx(40)
      }

      keyNavigationEnabled: false

      cacheBuffer: 0

      snapMode: GridView.SnapToRow

      highlightRangeMode: GridView.StrictlyEnforceRange
      highlightFollowsCurrentItem: true

      cellWidth: width / columnCount
      cellHeight: cellWidth * cellHeightRatio;

      // Current item should stay in the middle (ensures smooth scrolling)
      preferredHighlightBegin: (height - cellHeight) / 2
      preferredHighlightEnd: (height + cellHeight) / 2

      model: collection.games

      property real columnCount: {
        if (cellHeightRatio > 1.2) return 5;
        if (cellHeightRatio > 0.6) return 4;
        return 3;
      }

      onModelChanged: cellsNeedRecalc()
      onCountChanged: cellsNeedRecalc()

      function cellsNeedRecalc() {
        firstImageLoaded = false;
        cellHeightRatio = 0.5;
      }

      function calcHeightRatio(imageW, imageH) {
        cellHeightRatio = 0.5;

        if (imageW > 0 && imageH > 0)
          cellHeightRatio = imageH / imageW;
      }

      Keys.onUpPressed: {
        event.accepted = true;
        moveCurrentIndexUp();
      }
      Keys.onRightPressed: {
        event.accepted = true;
        moveCurrentIndexRight();
      }
      Keys.onDownPressed: {
        event.accepted = true;
        moveCurrentIndexDown();
      }
      Keys.onLeftPressed: {
        event.accepted = true;
        moveCurrentIndexLeft();
      }

      Keys.onPressed: {
        if (api.keys.isCancel(event)) {
          event.accepted = true;
          gamelistScreen.back();
        }
        else if (api.keys.isAccept(event)) {
          event.accepted = true;
          gamelistScreen.itemSelected(currentIndex);
        }
      }

      delegate: GameGridItem {
        width: GridView.view.cellWidth
        height: GridView.view.cellHeight
        state: gameGrid.zoomSelectedItem && GridView.isCurrentItem ? "selected" : ""
        columnCount: GridView.view.columnCount

        imageHeightRatio: gridView.firstImageLoaded ? gridView.cellHeightRatio : 0.5

        onClicked: selectItem();

        onDoubleClicked: {
          selectItem();
          // launchGame(collection, modelData);
        }

        onImageLoaded: {
          // NOTE: because images are loaded asynchronously,
          // firstImageLoaded may appear false multiple times!
          if (!gridView.firstImageLoaded) {
            gridView.firstImageLoaded = true;
            gridView.calcHeightRatio(imageWidth, imageHeight);
          }
        }

        function selectItem() {
          // console.log("selectItem", index);
          gridView.currentIndex = index
        }
      }
    }
  }
}
