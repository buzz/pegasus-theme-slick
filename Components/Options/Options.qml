import QtQuick 2.12
import QtQuick.Layouts 1.11
import QtGraphicalEffects 1.12
import "../utils.js" as Utils

FocusScope {
  id: options

  required property bool collectionsView

  signal setFilterSortCollections(string searchText, int sortIndex)
  signal setFilterSortGamelist(string searchText, int sortIndex)
  signal close

  function closeAndApply() {
    Utils.saveOptions({
      sortIndexCollections: sortCollections.currentIndex,
      sortIndexGamelist: sortGamelist.currentIndex,
    });
    close();
    if (collectionsView)
      setFilterSortCollections(searchInputCollections.searchText, sortCollections.currentIndex);
    else
      setFilterSortGamelist(searchInputGamelist.searchText, sortGamelist.currentIndex);
  }

  function resetSearchInputGamelist() {
    searchInputGamelist.searchText = "";
  }

  onFocusChanged: {
    if (focus) {
      if (collectionsView) {
        sortCollections.jumpTo(sortIndexCollections);
        searchInputCollections.focus = true;
      } else {
        sortGamelist.jumpTo(sortIndexGamelist);
        searchInputGamelist.focus = true;
      }
    }
  }

  Keys.onPressed: {
    if (api.keys.isFilters(event) || api.keys.isCancel(event)) {
      event.accepted = true;
      options.closeAndApply();
    }
  }

  // Drop shadow
  Rectangle {
    id: dropShadow

    width: background.width + vpx(6)
    height: background.height + vpx(6)
    anchors.centerIn: parent

    color: "#66000000"
    radius: radiusLarge

    layer.enabled: true
    layer.effect: GaussianBlur {
      radius: vpx(24)
      samples: vpx(49)
      transparentBorder: true
    }
  }

  // Transparent background
  Rectangle {
    id: background

    width: grid.width + vpx(40)
    height: grid.height + vpx(40)
    anchors.centerIn: parent

    color: "#c8000000"
    radius: radiusLarge
  }

  // Controls
  Item {
    anchors.fill: parent

    ColumnLayout {
      id: grid

      anchors.centerIn: parent

      spacing: spacingStd
      width: vpx(340)

      // Caption Search
      Caption {
        text: `Search ${collectionsView ? "collections" : "games"}`
        imageSource: "../../assets/search-solid.svg"

        Layout.fillWidth: true
        Layout.preferredHeight: vpx(20)
      }

      // Search input (collections)
      SearchTextInput {
        id: searchInputCollections

        Layout.fillWidth: true
        Layout.bottomMargin: spacingStd

        onAccept: options.closeAndApply()

        visible: collectionsView

        KeyNavigation.down: sortCollections
      }

      // Search input (games)
      SearchTextInput {
        id: searchInputGamelist

        Layout.fillWidth: true
        Layout.bottomMargin: spacingStd

        onAccept: options.closeAndApply()

        visible: !collectionsView

        KeyNavigation.down: sortGamelist
      }

      // Caption Sorting
      Caption {
        text: `Sort ${collectionsView ? "collections" : "games"} by`
        imageSource: "../../assets/sort-alpha-down-solid.svg"

        Layout.fillWidth: true
        Layout.preferredHeight: vpx(20)
      }

      // Sort (collections)
      Choice {
        id: sortCollections

        visible: collectionsView

        Layout.preferredHeight: vpx(28)
        Layout.fillWidth: true
        Layout.fillHeight: true
        Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
        Layout.bottomMargin: spacingStd

        model: listModelSortCollections

        KeyNavigation.up: searchInputCollections
        KeyNavigation.down: doneButton

        onAccept: options.closeAndApply()
      }

      // Sort (games)
      Choice {
        id: sortGamelist

        visible: !collectionsView

        Layout.preferredHeight: vpx(28)
        Layout.fillWidth: true
        Layout.fillHeight: true
        Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter

        model: listModelSortGamelist

        KeyNavigation.up: searchInputGamelist
        KeyNavigation.down: doneButton

        onAccept: options.closeAndApply()
      }

      // Done button
      Button {
        id: doneButton

        text: "Done"

        Layout.preferredHeight: vpx(24)
        Layout.fillWidth: true
        Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter

        KeyNavigation.up: collectionsView ? sortCollections : sortGamelist

        onActivate: close()
      }
    }
  }
}
