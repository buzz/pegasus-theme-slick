import QtQuick 2.8
import QtGraphicalEffects 1.12

import "Components/CollectionsView"
import "Components/DetailsView"

FocusScope {
  Component.onCompleted: {
    collectionsView.currentCollectionIndex = api.memory.get('collectionIndex') || 0;
  }

  FontLoader { id: generalFont; source: "assets/fonts/Rubik-Regular.ttf" }
  FontLoader { id: headerFont; source: "assets/fonts/BebasNeue.otf" }
  FontLoader { id: subheaderFont; source: "assets/fonts/Acre.otf" }

  CollectionsView {
    id: collectionsView
    anchors.bottom: parent.bottom
    focus: true

    onCollectionSelected: {
      // detailsView.currentGameIndex = api.memory.get(currentCollection.shortName + 'GameIndex') || 0;
      detailsView.focus = true
    }
  }

  DetailsView {
    id: detailsView
    anchors.top: collectionsView.bottom

    currentCollection: collectionsView.currentCollection

    onCancel: {
      api.memory.set('collectionIndex', collectionsView.currentCollectionIndex);
      // api.memory.set(currentCollection.shortName + 'GameIndex', currentGameIndex);
      collectionsView.focus = true;
      console.log("CANCEL");
    }
    onNextCollection: {
      api.memory.set('collectionIndex', collectionsView.currentCollectionIndex);
      // api.memory.set(currentCollection.shortName + 'GameIndex', currentGameIndex);
      collectionsView.selectNext();
      detailsView.currentGameIndex = api.memory.get(currentCollection.shortName + 'GameIndex') || 0;
    }
    onPrevCollection: {
      api.memory.set('collectionIndex', collectionsView.currentCollectionIndex);
      // api.memory.set(currentCollection.shortName + 'GameIndex', currentGameIndex);
      collectionsView.selectPrev();
      detailsView.currentGameIndex = api.memory.get(currentCollection.shortName + 'GameIndex') || 0;
    }
    onLaunchGame: {
      api.memory.set('collectionIndex', collectionsView.currentCollectionIndex);
      // api.memory.set(currentCollection.shortName + 'GameIndex', currentGameIndex);
      currentGame.launch();
    }
  }

  states: [
    State {
      when: detailsView.focus
      AnchorChanges {
        target: collectionsView;
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
