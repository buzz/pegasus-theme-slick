import QtQuick 2.15
import "../utils.js" as Utils

Item {
  Text {
    id: textSystemYear
    text: extra.year || ""
    color: colorFont
    font.family: subheaderFont.name
    font.pixelSize: fontSizeSubheader
    minimumPixelSize: fontSizeSubheaderMin

    anchors {
      left: parent.left
      leftMargin: marginHoriz
      top: parent.top
      topMargin: marginVert
    }
  }

  Text {
    id: textDot1
    text: extra.year ? " · " : ""
    color: colorFontLightlyTinted
    font.family: subheaderFont.name
    font.pixelSize: fontSizeSubheader
    minimumPixelSize: fontSizeSubheaderMin

    anchors {
      left: textSystemYear.right
      top: parent.top
      topMargin: marginVert
    }
  }

  Text {
    id: textSystemCompany
    text: extra["company"] || ""
    color: colorFont
    font.family: subheaderFont.name
    font.pixelSize: fontSizeSubheader
    minimumPixelSize: fontSizeSubheaderMin
    font.capitalization: Font.AllUppercase

    anchors {
      left: textDot1.right
      top: parent.top
      topMargin: marginVert
    }
  }

  Text {
    id: textDot2
    text: extra["company"] ? " · " : ""
    color: colorFontLightlyTinted
    font.family: subheaderFont.name
    font.pixelSize: fontSizeSubheader
    minimumPixelSize: fontSizeSubheaderMin

    anchors {
      left: textSystemCompany.right
      top: parent.top
      topMargin: marginVert
    }
  }

  Text {
    id: textSystemShortDescription
    text: extra["short-description"] || ""
    color: colorFontTinted
    font.family: subheaderFont.name
    font.pixelSize: fontSizeSubheader
    minimumPixelSize: fontSizeSubheaderMin
    font.capitalization: Font.AllUppercase

    anchors {
      left: textDot2.right
      top: parent.top
      topMargin: marginVert
    }
  }

  Text {
    id: textCollectionName
    text: "%1".arg(name) || ""
    color: colorFontStrong
    font.bold: true
    font.family: headerFont.name
    font.pixelSize: fontSizeHeader
    minimumPixelSize: fontSizeHeaderMin
    font.capitalization: Font.AllUppercase
    font.letterSpacing: -vpx(1.0)
    fontSizeMode: Text.Fit
    lineHeight: 0.9
    maximumLineCount: 2
    wrapMode: Text.Wrap
    width: vpx(640)

    anchors {
      left: parent.left
      leftMargin: marginHoriz
      top: textSystemShortDescription.bottom
      topMargin: vpx(25)
    }
  }

  Text {
    id: textCollectionGameCount
    text: "%1 AVAILABLE GAMES".arg(games.count)
    color: colorFontRed
    font.family: subheaderFont.name
    font.pixelSize: fontSizeSubheader
    minimumPixelSize: fontSizeSubheaderMin

    anchors {
      left: parent.left
      leftMargin: marginHoriz
      top: textCollectionName.bottom
      topMargin: vpx(22)
    }
  }

  Text {
    id: textCollectionDescription
    text: Utils.formatDescription(extra.description)
    color: colorFont
    font.family: subheaderFont.name
    font.pixelSize: fontSizeDescription
    minimumPixelSize: fontSizeDescriptionMin
    width: vpx(420)
    wrapMode: Text.Wrap

    anchors {
      left: parent.left
      leftMargin: marginHoriz
      top: textCollectionGameCount.bottom
      topMargin: vpx(14)
    }
  }
}
