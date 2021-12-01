import QtQuick 2.15
import QtGraphicalEffects 1.12

Item {
  id: collectionScreen

  // Collection image
  Item {
    id: collectionImage

    anchors {
      top: collectionScreen.top
      right: collectionScreen.right
      bottom: collectionScreen.bottom
      topMargin: marginVertCollectionScreen * 1.33
      rightMargin: marginHorizCollectionScreen / 2
      bottomMargin: marginVertCollectionScreen / 2
      leftMargin: marginHorizCollectionScreen
    }

    width: collectionScreen.width / 1.67
    height: collectionScreen.height
    scale: collectionScreen.ListView.isCurrentItem ? 1.0 : 0.5

    Behavior on scale {
      PropertyAnimation {
        duration: 450
        easing.type: Easing.OutCubic
      }
    }

    // Colored glow
    GaussianBlur {
      anchors.fill: bgImg

      cached: true
      source: bgImg
      radius: vpx(32)
      samples: vpx(65)

      transparentBorder: true
    }

    Image {
      id: bgImg

      width: Math.min(parent.width, implicitWidth)
      height: Math.min(parent.height, implicitHeight)

      anchors {
        bottom: parent.bottom
        right: parent.right
      }

      visible: true
      asynchronous: true
      fillMode: Image.PreserveAspectFit
      source: `../../assets/backgrounds/${shortName}.webp`
      smooth: true
    }
  }

  // Collection info text
  CollectionDetails {
    anchors.fill: parent

    transform: Translate {
      y: collectionScreen.ListView.isCurrentItem ? 0 : vpx(-900)

      Behavior on y {
        PropertyAnimation {
          duration: 550
          easing.type: Easing.OutQuint
        }
      }
    }
  }
}
