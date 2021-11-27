import QtQuick 2.15
import QtGraphicalEffects 1.12

import "CollectionsCarousel"
import "GamelistScreen"

FocusScope {
  id: main

  FontLoader { id: headerFont; source: "../assets/fonts/BebasNeue.otf" }
  FontLoader { id: subheaderFont; source: "../assets/fonts/Acre.otf" }

  property int restoredCollectionIndex

  Component.onCompleted: {
    restoredCollectionIndex = restoreCollectionIndex();
  }

  Component.onDestruction: {
    saveCollectionIndex();
    saveGameIndex();
  }

  function restoreCollectionIndex() {
    console.log(`main:restoreCollectionIndex`, api.memory.get('collectionIndex') || 0)
    return api.memory.get('collectionIndex') || 0;
  }

  function saveCollectionIndex(idx) {
    console.log(`main:saveCollectionIndex`, collectionsCarousel.currentIndex)
    api.memory.set('collectionIndex', collectionsCarousel.currentIndex);
  }

  function restoreGameIndex(collectionShortName) {
    console.log(`main:restoreGameIndex ${collectionShortName}`, api.memory.get(`${collectionShortName}GameIndex`) || 0)
    return api.memory.get(`${collectionShortName}GameIndex`) || 0;
  }

  function saveGameIndex() {
    const collection = api.collections.get(collectionsCarousel.currentIndex);
    const gameIdx = gamelistScreen.getCurrentGameIndex();
    console.log(`main:saveGameIndex ${collection.shortName} ${gameIdx}`);
    if (collection && gameIdx !== undefined) {
      api.memory.set(`${collection.shortName}GameIndex`, gameIdx);
    }
  }

  function launchGame(collection, game) {
    console.log(`main:launchGame ${collection.shortName} ${game.name}`);
    game.launch();
  }

  Keys.onPressed: {
    if (!collectionsCarousel.horizontalVelocity) {
      if (api.keys.isNextPage(event)) {
        console.log("main:NextPage");
        event.accepted = true;
        saveGameIndex();
        collectionsCarousel.incrementCurrentIndex();
      } else if (api.keys.isPrevPage(event)) {
        console.log("main:PrevPage");
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

    onCurrentIndexChanged: {
      console.log("main:CollectionsCarousel:onCurrentIndexChanged", currentIndex);
      gamelistScreen.collection = api.collections.get(currentIndex);
    }

    Keys.onPressed: {
      if (api.keys.isAccept(event)) {
        // console.log("CollectionsCarousel:itemSelected");
        event.accepted = true;
        saveCollectionIndex();
        gamelistScreen.focus = true;
      }
    }
    Keys.onRightPressed: {
      // console.log("CollectionsCarousel:Keys.onRightPressed moving=", horizontalVelocity);
      if (!horizontalVelocity) {
        event.accepted = true;
        incrementCurrentIndex();
      }
    }
    Keys.onLeftPressed: {
      // console.log("CollectionsCarousel:Keys.onLeftPressed moving=", horizontalVelocity);
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

    collection: collectionsCarousel.currentItem

    onBack: {
      console.log("main:GamelistsCarousel:onBack");
      saveCollectionIndex();
      saveGameIndex();
      collectionsCarousel.focus = true
    }

    onItemSelected: {
      // console.log("main:GamelistsCarousel:onItemSelected");
      saveCollectionIndex();
      saveGameIndex();
      const game = gamelistScreen.collection.games.get(gameIndex)
      console.log("main:GamelistsCarousel:onItemSelected", game);
      main.launchGame(gamelistScreen.collection, game);
    }
  }

  states: [
    State {
      when: gamelistScreen.focus
      AnchorChanges {
        target: collectionsCarousel;
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
