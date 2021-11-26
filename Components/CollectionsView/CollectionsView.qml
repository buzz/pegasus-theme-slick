import QtQuick 2.8

FocusScope {
  id: root

  readonly property int marginLeft: 96
  readonly property int marginTop: 70

  readonly property int fontSizeDescription: 14
  readonly property int fontSizeDescriptionMin: 12
  readonly property int fontSizeSubheader: 21
  readonly property int fontSizeSubheaderMin: 14
  readonly property int fontSizeHeader: 120
  readonly property int fontSizeHeaderMin: 100

  property int currentCollectionIndex
  readonly property var currentCollection: api.collections.get(currentCollectionIndex)

  // This element has the same size as the whole screen (ie. its parent).
  // Because this screen itself will be moved around when a collection is
  // selected, I've used width/height instead of anchors.
  width: parent.width
  height: parent.height
  enabled: focus // do not receive key/mouse events when unfocused
  visible: y + height >= 0 // optimization: do not render the item when it's not on screen

  signal collectionSelected

  Keys.onLeftPressed: selectPrev()
  Keys.onRightPressed: selectNext()

  Keys.onPressed: {
    if (api.keys.isAccept(event)) {
      event.accepted = true;
      collectionSelected();
    }
  }

  function selectNext() {
    if (currentCollectionIndex < api.collections.count - 1) {
      currentCollectionIndex += 1;
    }
  }

  function selectPrev() {
    if (currentCollectionIndex > 0) {
      currentCollectionIndex -= 1;
    }
  }

  CollectionBackground {
    id: collectionBackground
    currentCollection: root.currentCollection
  }

  CollectionDetails {
    currentCollection: root.currentCollection
  }
}
