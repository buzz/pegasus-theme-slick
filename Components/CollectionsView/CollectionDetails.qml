import QtQuick 2.8
import "../utils.js" as Utils

Item {
  id: collectionDetails

  property var currentCollection

  anchors.fill: parent

  Text {
    id: textSystemYear
    text: currentCollection.extra.year || ""
    color: "#888888"
    font.family: subheaderFont.name
    font.pixelSize: vpx(fontSizeSubheader)
    minimumPixelSize: vpx(fontSizeSubheaderMin)

    anchors {
      left: parent.left
      leftMargin: vpx(marginLeft)
      top: parent.top
      topMargin: vpx(marginTop)
    }
  }

  Text {
    id: textDot1
    text: currentCollection.extra.year ? " · " : ""
    color: "#616161"
    font.family: subheaderFont.name
    font.pixelSize: vpx(fontSizeSubheader)
    minimumPixelSize: vpx(fontSizeSubheaderMin)

    anchors {
      left: textSystemYear.right
      top: parent.top
      topMargin: vpx(marginTop)
    }
  }

  Text {
    id: textSystemCompany
    text: currentCollection.extra['company'] || ""
    color: "#888888"
    font.family: subheaderFont.name
    font.pixelSize: vpx(fontSizeSubheader)
    minimumPixelSize: vpx(fontSizeSubheaderMin)
    font.capitalization: Font.AllUppercase

    anchors {
      left: textDot1.right
      top: parent.top
      topMargin: vpx(marginTop)
    }
  }

  Text {
    id: textDot2
    text: currentCollection.extra['company'] ? " · " : ""
    color: "#616161"
    font.family: subheaderFont.name
    font.pixelSize: vpx(fontSizeSubheader)
    minimumPixelSize: vpx(fontSizeSubheaderMin)

    anchors {
      left: textSystemCompany.right
      top: parent.top
      topMargin: vpx(marginTop)
    }
  }

  Text {
    id: textSystemShortDescription
    text: currentCollection.extra['short-description'] || ""
    color: "#3a3a3a"
    font.family: subheaderFont.name
    font.pixelSize: vpx(fontSizeSubheader)
    minimumPixelSize: vpx(fontSizeSubheaderMin)
    font.capitalization: Font.AllUppercase

    anchors {
      left: textDot2.right
      top: parent.top
      topMargin: vpx(marginTop)
    }
  }

  Text {
    id: textCollectionName
    text: "%1".arg(currentCollection.name) || ""
    color: "white"
    font.bold: true
    font.family: headerFont.name
    font.pixelSize: vpx(fontSizeHeader)
    minimumPixelSize: vpx(fontSizeHeaderMin)
    font.capitalization: Font.AllUppercase
    fontSizeMode: Text.Fit
    lineHeight: 0.9
    maximumLineCount: 2
    wrapMode: Text.Wrap
    width: vpx(640)

    anchors {
      left: parent.left
      leftMargin: vpx(marginLeft)
      top: textSystemShortDescription.bottom
      topMargin: vpx(25)
    }
  }

  Text {
    id: textCollectionGameCount
    text: "%1 AVAILABLE GAMES".arg(currentCollection.games.count)
    color: "#e1303a"
    font.family: subheaderFont.name
    font.pixelSize: vpx(fontSizeSubheader)
    minimumPixelSize: vpx(fontSizeSubheaderMin)

    anchors {
      left: parent.left
      leftMargin: vpx(marginLeft)
      top: textCollectionName.bottom
      topMargin: vpx(22)
    }
  }

  Text {
    id: textCollectionDescription
    text: Utils.formatDescription(currentCollection.extra.description)
    color: "#888888"
    font.family: subheaderFont.name
    font.pixelSize: vpx(fontSizeDescription)
    minimumPixelSize: vpx(fontSizeDescriptionMin)
    width: vpx(420)
    wrapMode: Text.Wrap

    anchors {
      left: parent.left
      leftMargin: vpx(marginLeft)
      top: textCollectionGameCount.bottom
      topMargin: vpx(14)
    }
  }
}
