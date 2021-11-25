import QtQuick 2.8
import QtGraphicalEffects 1.12

Item {
  id: root
  property alias currentGameIndex: gridView.currentIndex

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

  // Opacity mask needs to be larger as selected item may stick out of grid
  // and would be clipped.
  Item {
    anchors.fill: parent

    layer.enabled: true
    layer.effect: OpacityMask {
      maskSource: gradientMask
    }

    GridView {
      id: gridView

      anchors {
        top: parent.top
        right: parent.right
        rightMargin: vpx(40)
        bottom: parent.bottom
        left: parent.left
        leftMargin: vpx(40)
      }

      property bool firstImageLoaded: false
      property real cellHeightRatio: 0.5

      function cellsNeedRecalc() {
        firstImageLoaded = false;
        cellHeightRatio = 0.5;
      }

      focus: true
      snapMode: GridView.SnapToRow

      // Current item should stay in the middle (ensures smooth scrolling)
      preferredHighlightBegin: (height - cellHeight) / 2
      preferredHighlightEnd: (height + cellHeight) / 2
      highlightRangeMode: GridView.StrictlyEnforceRange
      highlightFollowsCurrentItem: true

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

      delegate: GameGridItem {
        width: GridView.view.cellWidth
        height: GridView.view.cellHeight
        state: GridView.isCurrentItem && "selected"
        columnCount: GridView.view.columnCount

        game: modelData

        imageHeightRatio: {
          return gridView.firstImageLoaded ? gridView.cellHeightRatio : 0.5;
        }

        onClicked: {
          gridView.currentIndex = index;
        }

        onDoubleClicked: {
          gridView.currentIndex = index;
          launchGame();
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
}
