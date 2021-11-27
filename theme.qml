import "Components"

Main {
  // Colors
  readonly property color colorBgTop: "#aa000000"
  readonly property color colorBgCenter: "#77000000"
  readonly property color colorBgBottom: "#77010101"

  readonly property color colorBoxBorder: "#333333"
  readonly property color colorBgMetaBox: "#aaffffff"
  readonly property color colorBgBoxArt: "#888888"

  // Font colors
  readonly property color colorFont: "#888888"
  readonly property color colorFontLightlyTinted: "#616161"
  readonly property color colorFontTinted: "#3a3a3a"
  readonly property color colorFontStrong: "#ffffff"
  readonly property color colorFontRed: "#e1303a"
  readonly property color colorFontBox: "#222222"
  readonly property color colorFontBoxValue: "#111111"

  // Font sizes
  readonly property int fontSizeDescription: vpx(14)
  readonly property int fontSizeDescriptionMin: vpx(12)
  readonly property int fontSizeSubheader: vpx(21)
  readonly property int fontSizeSubheaderMin: vpx(14)
  readonly property int fontSizeHeader: vpx(120)
  readonly property int fontSizeHeaderMin: vpx(100)

  // Animations
  readonly property int durationShort: 150
  readonly property int durationMedium: 300
  readonly property int durationLong: 600
  readonly property int durationPlayVideo: 1500 // time until video replaces image
  readonly property int durationLoadingSpinner: 1333

  // Margin
  readonly property int marginHoriz: vpx(96)
  readonly property int marginVert: vpx(70)

  // Misc
  readonly property real boxArtScaleFactor: 3
}
