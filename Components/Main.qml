import QtQuick 2.15
import QtGraphicalEffects 1.12
import "SearchFilter"
import "Options"
import "utils.js" as Utils

FocusScope {
  id: main

  // Prevent filter reset collection on initial load
  property bool initialLoad: true

  // Current collection/game index
  property int currentCollectionIndex: -1
  property int currentGameIndex: -1

  // Sorting/filtering
  property string searchTextCollections: ""
  property int sortIndexCollections: 0
  property string prevCollectionShortName: "" // collection to jump to jump

  property string searchTextGamelist: ""
  property int sortIndexGamelist: 0
  property string prevGamePath: "" // remember game to jump to jump

  Component.onCompleted: {
    prevCollectionShortName = Utils.restoreCollection();

    const options = Utils.restoreOptions();
    sortIndexCollections = options.sortIndexCollections;
    sortIndexGamelist = options.sortIndexGamelist;

    Qt.callLater(collectionSearchFilter.restoreCollection);

    // Go to gamelist if we're coming back from a game
    if (Utils.isGameLaunch())
      mainSwitcher.showGamelist();
  }

  onCurrentCollectionIndexChanged: {
    const collection = collectionSearchFilter.get(currentCollectionIndex);
    if (collection && collection.games)
      gamelistSearchFilter.sourceModel = collection.games;
    mainSwitcher.jumpToCollection();

    // Reset gamelist search text
    searchTextGamelist = "";
    options.resetSearchInputGamelist();

    Qt.callLater(mainSwitcher.jumpToGame);
  }

  onCurrentGameIndexChanged: {
    Qt.callLater(mainSwitcher.jumpToGame);
  }

  Component.onDestruction: {
    Utils.saveCollection();
    Utils.saveGame();
  }

  function launchGame() {
    Utils.saveCollection();
    Utils.saveGame();
    Utils.saveGameLaunch();

    const game = gamelistSearchFilter.get(currentGameIndex);
    if (game && game.modelData)
      game.modelData.launch();
  }

  // Search/filter collection

  CollectionSortFilterProxyModel {
    id: collectionSearchFilter

    sourceModel: api.collections

    searchText: main.searchTextCollections
    sortIndex: main.sortIndexCollections

    function restoreCollection() {
      main.initialLoad = false;

      if (count) {
        if (prevCollectionShortName) {
          // Restore collection from before
          mainSwitcher.goToCollectionByShortName(prevCollectionShortName);
          prevCollectionShortName = "";
        } else {
          currentCollectionIndex = 0;
        }
      }
    }

    // Restore collection after search/filter change
    onChanged: {
      if (!initialLoad)
        Qt.callLater(collectionSearchFilter.restoreCollection);
    }
  }

  GamelistSortFilterProxyModel {
    id: gamelistSearchFilter

    searchText: main.searchTextGamelist
    sortIndex: main.sortIndexGamelist

    function restoreGame() {
      // No games
      if (count === 0) {
        currentGameIndex = -1;
        return;
      }

      // Restore game from before
      if (prevGamePath) {
        mainSwitcher.goToGameByPath(prevGamePath);
        prevGamePath = "";
        return
      }

      // Otherwise show first game
      currentGameIndex = 0;
    }

    onSourceModelChanged: {
      if (count) {
        prevGamePath = Utils.restoreGame();
        Qt.callLater(gamelistSearchFilter.restoreGame);
      }
    }

    // Restore game after search/filter change
    onChanged: Qt.callLater(gamelistSearchFilter.restoreGame)
  }

  Keys.onPressed: {
    if (api.keys.isFilters(event)) {
      event.accepted = true;
      options.focus = true;
    }
  }

  MainSwitcher {
    id: mainSwitcher

    optionsView: options.focus

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
        const prevCollection = collectionSearchFilter.get(currentCollectionIndex);
        main.prevCollectionShortName = prevCollection && prevCollection.shortName ? prevCollection.shortName : "";
      } else {
        const prevGame = gamelistSearchFilter.get(currentGameIndex);
        if (prevGame && prevGame.files && prevGame.files.count)
          main.prevGamePath = prevGame.files.get(0).path;
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
