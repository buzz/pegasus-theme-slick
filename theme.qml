import "Components"

Main {
  // Colors
  readonly property color colorBg: "#0c0c0c"
  readonly property color colorBoxBorder: "#333333"
  readonly property color colorBgBox: "#888888"

  // Fonts
  readonly property color colorFont: "#888888"
  readonly property color colorFontLightlyTinted: "#616161"
  readonly property color colorFontTinted: "#3a3a3a"
  readonly property color colorFontStrong: "#ffffff"
  readonly property color colorFontRed: "#e1303a"
  readonly property color colorFontBox: "#222222"

  // Animations
  readonly property int durationShort: 150
  readonly property int durationMedium: 300
  readonly property int durationLong: 600
  readonly property int durationPlayVideo: 1500 // time until video replaces image
  readonly property int durationLoadingSpinner: 1333

  // Misc
  readonly property real boxArtScaleFactor: 3
}
