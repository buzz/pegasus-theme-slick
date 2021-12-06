import QtQuick 2.15
import QtGraphicalEffects 1.12
import "CollectionsCarousel"
import "GamelistScreen"
import "utils.js" as Utils

FocusScope {
  id: mainSwitcher

  property bool collectionsView: !gamelistScreen.focus
  required property bool optionsView

  function jumpToCollection() {
    collectionsCarousel.jumpTo();
    gamelistScreen.jumpToCollection();
  }
  function jumpToGame() {
    gamelistScreen.jumpToGame();
  }

  // Restore collection from before search/filter
  function goToCollection(shortName) {
    if (shortName) {
      let idx = 0;
      for (let i = 0; i < collectionSearchFilter.count; ++i) {
        const c = collectionSearchFilter.get(i);
        if (c.shortName === shortName) {
          idx = i;
          break;
        }
      }
      collectionsCarousel.positionViewAtIndex(idx, ListView.SnapPosition);
      collectionsCarousel.currentIndex = idx;
    }
  }

  // Restore game from before search/filter
  function goToGame(path) {
    let idx = 0;
    for (let i = 0; i < gamelistSearchFilter.count; ++i) {
      const g = gamelistSearchFilter.get(i);
      if (g.files.count && g.files.get(0).path === path) {
        idx = i;
        break;
      }
    }
    currentGameIndex = idx;
  }

  Keys.onPressed: {
    if (!collectionsCarousel.horizontalVelocity) {
      if (api.keys.isNextPage(event)) {
        event.accepted = true;
        Utils.saveGameIndex();
        collectionsCarousel.incrementCurrentIndex();
      } else if (api.keys.isPrevPage(event)) {
        event.accepted = true;
        Utils.saveGameIndex();
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

    onSelect: {
      const collection = collectionSearchFilter.get(currentCollectionIndex);
      if (collection && collection.games && collection.games.count) {
        Utils.saveCollectionIndex();
        gamelistScreen.focus = true;
      }
    }
  }

  GamelistScreen {
    id: gamelistScreen

    width: main.width
    height: main.height
    anchors.top: collectionsCarousel.bottom

    onBack: {
      Utils.saveCollectionIndex();
      Utils.saveGameIndex();
      collectionsCarousel.focus = true;
    }

    onItemSelected: main.launchGame()
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
