import QtQuick 2.15
import "Components"

Main {
  // Colors
  readonly property color colorBgTop: "#aa000000"
  readonly property color colorBgCenter: "#77000000"
  readonly property color colorBgBottom: "#77010101"

  readonly property color colorBoxBorder: "#333333"
  readonly property color colorBgMetaBox: "#aaffffff"
  readonly property color colorBgBoxArt: "#888888"

  readonly property color colorTextInputBg: "#0cffffff"
  readonly property color colorControlBgHighlight: "#11ffffff"

  // Fonts
  FontLoader { id: headerFont; source: "assets/fonts/BebasNeue.otf" }
  FontLoader { id: generalFont; source: "assets/fonts/Acre.otf" }

  // Font colors
  readonly property color colorFont: "#888888"
  readonly property color colorFontLightlyTinted: "#616161"
  readonly property color colorFontTinted: "#3a3a3a"
  readonly property color colorFontStrong: "#ffffff"
  readonly property color colorFontRed: "#e1303a"
  readonly property color colorFontBox: "#222222"
  readonly property color colorFontBoxValue: "#111111"

  readonly property color colorFontOptions: "#aaaaaa"
  readonly property color colorFontOptionsSelected: "#ffffff"

  // Font sizes
  readonly property int fontSizeRegular: vpx(14)
  readonly property int fontSizeCollectionSubheader: vpx(21)
  readonly property int fontSizeCollectionHeader: vpx(120)

  readonly property int fontSizeGameDetailsSubheader: vpx(21)
  readonly property int fontSizeGameDetailsHeader: vpx(56)

  readonly property int fontSizeOptionsHeader: vpx(26)
  readonly property int fontSizeOptions: vpx(18)

  // Animations
  readonly property int durationVeryShort: 100
  readonly property int durationShort: 150
  readonly property int durationMedium: 300
  readonly property int durationLong: 600
  readonly property int durationPlayVideo: 1500 // time until video replaces image
  readonly property int durationLoadingSpinner: 1333

  // Margins
  readonly property int marginHorizCollectionScreen: vpx(96)
  readonly property int marginVertCollectionScreen: vpx(70)
  readonly property int marginHorizGamelistScreen: vpx(40)
  readonly property int marginVertGamelistScreen: vpx(40)
  readonly property int spacingStd: vpx(10)
  readonly property int spacingHorizStd: vpx(10)
  readonly property int spacingVertStd: vpx(6)

  // Misc
  readonly property real boxArtScaleFactor: 3
  readonly property int radiusSmall: vpx(4)
  readonly property int radiusLarge: vpx(12)

  // Sorting
  ListModel {
    id: listModelSortCollections

    ListElement { name: "Name"; roleName: "sortBy" }
    ListElement { name: "Year"; roleName: "year" }
    ListElement { name: "Company"; roleName: "company" }
  }
  ListModel {
    id: listModelSortGamelist

    ListElement { name: "Title"; roleName: "sortBy" }
    ListElement { name: "Year"; roleName: "releaseYear" }
    ListElement { name: "Developer"; roleName: "developer" }
    ListElement { name: "Publisher"; roleName: "publisher" }
    ListElement { name: "Genre"; roleName: "genre" }
    ListElement { name: "Play time"; roleName: "playTime" }
    ListElement { name: "Last played"; roleName: "lastPlayed" }
  }
}
