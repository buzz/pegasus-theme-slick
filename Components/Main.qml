import QtQuick 2.15
import QtGraphicalEffects 1.12

import "SearchFilter"
import "Options"

FocusScope {
  id: main

  property int restoredCollectionIndex

  Component.onCompleted: restoredCollectionIndex = restoreCollectionIndex()

  Component.onDestruction: {
    saveCollectionIndex();
    saveGameIndex();
  }

  // Search/filter collection

  property string searchTextCollections: ""
  property var sortIndexCollections: 0
  property string prevCollectionShortName: "" // remember collection to jump to after filter/sort

  property string searchTextGamelist: ""
  property var sortIndexGamelist: 1
  property string prevGameShortName: "" // remember game to jump to after filter/sort

  CollectionSortFilterProxyModel {
    id: collectionSearchFilter

    sourceModel: api.collections

    searchText: main.searchTextCollections
    sortIndex: main.sortIndexCollections

    // Restore collection from before filter/sort
    onChanged: {
      if (prevCollectionShortName) {
        mainSwitcher.goToCollection(prevCollectionShortName);
        prevCollectionShortName = "";
      }
    }
  }

  GamelistSortFilterProxyModel {
    id: gamelistSearchFilter

    sourceModel: collectionSearchFilter.get(mainSwitcher.currentCollectionsIndex).games

    searchText: main.searchTextGamelist
    sortIndex: main.sortIndexGamelist

    // Restore game from before filter/sort
    onChanged: {
      if (prevGameShortName) {
        mainSwitcher.goToGame(prevGameShortName);
        prevGameShortName = "";
      }
    }
  }

  Keys.onPressed: {
    if (api.keys.isFilters(event)) {
      event.accepted = true;
      options.focus = true;
    }
  }

  function restoreCollectionIndex() {
    return api.memory.get('collectionIndex') || 0;
  }

  function saveCollectionIndex() {
    api.memory.set('collectionIndex', mainSwitcher.currentCollectionsIndex);
  }

  function restoreGameIndex(collectionShortName) {
    return api.memory.get(`${collectionShortName}GameIndex`) || 0;
  }

  function saveGameIndex() {
    const collection = api.collections.get(mainSwitcher.currentCollectionsIndex);
    const gameIdx = mainSwitcher.currentGameIndex;
    if (collection && gameIdx !== null) {
      api.memory.set(`${collection.shortName}GameIndex`, gameIdx);
    }
  }

  function launchGame(collection, game) {
    // TODO: save collection/state and restore after returning to pegasus
    game.launch();
  }

  MainSwitcher {
    id: mainSwitcher
    anchors.fill: parent
    focus: true
  }

  // Options
  MouseArea { // Prevent mouse actions on lower elements
    anchors.fill: parent
    enabled: options.focus
  }
  GaussianBlur {
    anchors.fill: parent

    source: mainSwitcher
    radius: options.focus ? vpx(24) : 0
    samples: vpx(49)

    Behavior on radius {
      PropertyAnimation {
        duration: durationShort
        easing.type: Easing.OutQuad
      }
    }
  }
  Options {
    id: options

    collectionsView: mainSwitcher.collectionsView

    anchors.fill: parent
    opacity: 0

    onClose: {
      mainSwitcher.focus = true;
      // Remember previous collection/game to jump to after updating model
      if (mainSwitcher.collectionsView) {
        const prevCollection = collectionSearchFilter.get(mainSwitcher.currentCollectionsIndex);
        main.prevCollectionShortName = prevCollection ? prevCollection.shortName : "";
      } else {
        // TODO
      }
    }

    onSetFilterSortCollections: {
      main.searchTextCollections = searchText;
      main.sortIndexCollections = sortIndex;
    }

    onSetFilterSortGamelist: {
      main.searchTextGamelist = searchText;
      main.sortIndexGamelist = sortIndex;
    }

    Behavior on opacity {
      PropertyAnimation {
        duration: durationVeryShort
        easing.type: Easing.OutQuad
      }
    }
  }

  states: [
    State {
      when: options.focus
      PropertyChanges {
        target: options
        opacity: 1.0
      }
    }
  ]
}
