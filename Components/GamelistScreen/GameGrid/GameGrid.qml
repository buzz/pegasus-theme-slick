import QtQuick 2.15
import QtGraphicalEffects 1.12

Item {
  id: gameGrid

  // Delay animation and scroll to item to make things work
  property bool enableSelectedItem: false

  required property bool optionsView

  onOptionsViewChanged: {
    if (!optionsView)
      resetSelectedItem();
  }

  function jumpToCollection() {
    gridView.cellsNeedRecalc();
    if (!collectionsView)
      resetSelectedItem();
  }

  function jumpToGame() {
    if (currentGameIndex >= 0 && currentGameIndex !== gridView.currentIndex)
      resetSelectedItem();
  }

  function resetSelectedItem() {
    enableSelectedItem = false;
    resetSelectedTimer.restart();
  }

  Timer {
    id: resetSelectedTimer

    interval: durationVeryShort
    onTriggered: {
      gridView.currentIndex = currentGameIndex;
      enableSelectedItem = true;
    }
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
        rightMargin: marginHorizGamelistScreen
        leftMargin: marginHorizGamelistScreen
      }

      model: gamelistSearchFilter

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

      property real columnCount: {
        if (cellHeightRatio > 1.2) return 5;
        if (cellHeightRatio > 0.6) return 4;
        return 3;
      }

      function cellsNeedRecalc() {
        firstImageLoaded = false;
        cellHeightRatio = 0.5;
      }

      function calcHeightRatio(imageW, imageH) {
        cellHeightRatio = 0.5;

        if (imageW > 0 && imageH > 0)
          cellHeightRatio = imageH / imageW;
      }

      onModelChanged: cellsNeedRecalc()

      onCurrentIndexChanged: {
        if (enableSelectedItem)
          currentGameIndex = currentIndex;
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
          gamelistScreen.itemSelected();
        }
      }

      delegate: GameGridItem {
        width: GridView.view.cellWidth
        height: GridView.view.cellHeight
        state: !optionsView && gameGrid.enableSelectedItem && GridView.isCurrentItem ? "selected" : ""
        columnCount: GridView.view.columnCount

        imageHeightRatio: gridView.firstImageLoaded ? gridView.cellHeightRatio : 0.5

        onClicked: selectItem();

        onDoubleClicked: {
          selectItem();
          gamelistScreen.itemSelected()
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
          gridView.currentIndex = index;
        }
      }
    }
  }
}
