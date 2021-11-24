import QtQuick 2.8

FocusScope {
  id: detailsView

  property var currentCollection
//   property alias currentGameIndex: grid.currentIndex
//   readonly property var currentGame: currentCollection.games.get(currentGameIndex)

  signal cancel
  signal nextCollection
  signal prevCollection
  signal launchGame

  Keys.onPressed: {
    if (event.isAutoRepeat)
      return;

    if (api.keys.isAccept(event)) {
      event.accepted = true;
      launchGame();
      return;
    }
    if (api.keys.isCancel(event)) {
      event.accepted = true;
      cancel();
      return;
    }
    if (api.keys.isNextPage(event)) {
      event.accepted = true;
      nextCollection();
      return;
    }
    if (api.keys.isPrevPage(event)) {
      event.accepted = true;
      prevCollection();
      return;
    }
  }
}

// Image {
//   id: imageCollectionName
//   source: "../../assets/logos/%1.svg".arg(currentCollection.shortName)
//   fillMode: Image.PreserveAspectFit
//   width: vpx(200)
//   height: vpx(50)

//   anchors {
//     left: parent.left
//     leftMargin: vpx(marginLeft)
//     bottom: parent.bottom
//     bottomMargin: vpx(marginTop)
//   }
// }
