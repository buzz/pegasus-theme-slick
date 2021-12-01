import QtQuick 2.15
import QtGraphicalEffects 1.12
import "CollectionsCarousel"
import "GamelistScreen"

FocusScope {
  property bool collectionsView: !gamelistScreen.focus

  property alias currentCollectionsIndex: collectionsCarousel.currentIndex
  property alias currentGameIndex: gamelistScreen.currentGameIndex

  function getCollectionIdxByShortName(collShortName) {
    for (let i = 0; i < collectionSearchFilter.count; ++i) {
      const c = collectionSearchFilter.get(i);
      if (c.shortName === collShortName)
        return i
    }
    return undefined;
  }

  // Restore collection from before search/filter
  function goToCollection(shortName) {
    if (shortName) {
      const idx = getCollectionIdxByShortName(shortName) || 0;
      collectionsCarousel.positionViewAtIndex(idx, ListView.SnapPosition);
      collectionsCarousel.currentIndex = idx;
    }
  }

  Keys.onPressed: {
    if (!collectionsCarousel.horizontalVelocity) {
      if (api.keys.isNextPage(event)) {
        event.accepted = true;
        saveGameIndex();
        collectionsCarousel.incrementCurrentIndex();
      } else if (api.keys.isPrevPage(event)) {
        event.accepted = true;
        saveGameIndex();
        collectionsCarousel.decrementCurrentIndex();
      }
    }
  }

  // Background
  Item {
    anchors.fill: parent

    Image {
      anchors.fill: parent

      source: "../assets/background-noise.webp"
      fillMode: Image.Tile
    }

    LinearGradient {
      anchors.fill: parent

      cached: true
      gradient: Gradient {
        GradientStop { position: 0.0; color: colorBgTop}
        GradientStop { position: 0.667; color: colorBgCenter}
        GradientStop { position: 1.0; color: colorBgBottom}
      }
    }
  }

  CollectionsCarousel {
    id: collectionsCarousel

    focus: true

    width: main.width
    height: main.height
    anchors.bottom: parent.bottom

    onCurrentIndexChanged: gamelistScreen.collection = collectionSearchFilter.get(currentIndex)

    Keys.onPressed: {
      if (api.keys.isAccept(event)) {
        event.accepted = true;
        saveCollectionIndex();
        gamelistScreen.focus = true;
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
  }

  GamelistScreen {
    id: gamelistScreen

    width: main.width
    height: main.height
    anchors.top: collectionsCarousel.bottom

    collection: collectionSearchFilter.get(collectionsCarousel.currentIndex)

    onBack: {
      saveCollectionIndex();
      saveGameIndex();
      collectionsCarousel.focus = true
    }

    onItemSelected: {
      saveCollectionIndex();
      saveGameIndex();
      const game = gamelistScreen.collection.games.get(gameIndex)
      main.launchGame(gamelistScreen.collection, game);
    }
  }

  states: [
    State {
      when: gamelistScreen.focus
      AnchorChanges {
        target: collectionsCarousel
        anchors.bottom: parent.top
      }
    }
  ]

  transitions: Transition {
    AnchorAnimation {
      duration: 666
      easing.type: Easing.OutExpo
    }
  }
}
