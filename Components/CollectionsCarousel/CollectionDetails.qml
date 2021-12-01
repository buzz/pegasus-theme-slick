import QtQuick 2.15

Item {
  Text {
    id: textSystemYear
    text: extra.year || ""
    color: colorFont
    font.family: generalFont.name
    font.pixelSize: fontSizeCollectionSubheader

    anchors {
      left: parent.left
      leftMargin: marginHorizCollectionScreen
      top: parent.top
      topMargin: marginVertCollectionScreen
    }
  }

  Text {
    id: textDot1
    text: extra.year ? " · " : ""
    color: colorFontLightlyTinted
    font.family: generalFont.name
    font.pixelSize: fontSizeCollectionSubheader

    anchors {
      left: textSystemYear.right
      top: parent.top
      topMargin: marginVertCollectionScreen
    }
  }

  Text {
    id: textSystemCompany
    text: extra.company || ""
    color: colorFont
    font.family: generalFont.name
    font.pixelSize: fontSizeCollectionSubheader
    font.capitalization: Font.AllUppercase

    anchors {
      left: textDot1.right
      top: parent.top
      topMargin: marginVertCollectionScreen
    }
  }

  Text {
    id: textDot2
    text: extra.company ? " · " : ""
    color: colorFontLightlyTinted
    font.family: generalFont.name
    font.pixelSize: fontSizeCollectionSubheader

    anchors {
      left: textSystemCompany.right
      top: parent.top
      topMargin: marginVertCollectionScreen
    }
  }

  Text {
    id: textSystemShortDescription
    text: summary || ""
    color: colorFontTinted
    font.family: generalFont.name
    font.pixelSize: fontSizeCollectionSubheader
    font.capitalization: Font.AllUppercase

    anchors {
      left: textDot2.right
      top: parent.top
      topMargin: marginVertCollectionScreen
    }
  }

  Text {
    id: textCollectionName
    text: name
    color: colorFontStrong
    font.bold: true
    font.family: headerFont.name
    font.pixelSize: fontSizeCollectionHeader
    font.capitalization: Font.AllUppercase
    font.letterSpacing: -vpx(1.25)
    renderType: Text.NativeRendering
    fontSizeMode: Text.Fit
    lineHeight: 0.85
    maximumLineCount: 2
    wrapMode: Text.Wrap
    width: vpx(640)

    anchors {
      left: parent.left
      leftMargin: marginHorizCollectionScreen
      top: textSystemShortDescription.bottom
      topMargin: vpx(25)
    }
  }

  Text {
    id: textCollectionGameCount
    text: `${games.count} AVAILABLE GAMES`
    color: colorFontRed
    font.family: generalFont.name
    font.pixelSize: fontSizeCollectionSubheader

    anchors {
      left: parent.left
      leftMargin: marginHorizCollectionScreen
      top: textCollectionName.bottom
      topMargin: vpx(22)
    }
  }

  Text {
    id: textCollectionDescription
    text: description
    color: colorFont
    font.family: generalFont.name
    font.pixelSize: fontSizeRegular
    width: vpx(420)
    wrapMode: Text.Wrap

    anchors {
      left: parent.left
      leftMargin: marginHorizCollectionScreen
      top: textCollectionGameCount.bottom
      topMargin: vpx(14)
    }
  }
}
