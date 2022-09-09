import QtQuick 2.12
import QtQuick.Layouts 1.11
import "utils.js" as Utils

Item {
  id: gameDetails

  property var game

  ColumnLayout {
    anchors {
      fill: parent
      leftMargin: marginHorizGamelistScreen
      topMargin: marginVertGamelistScreen
    }

    // Collection name
    Text {
      id: collectionName

      Layout.alignment: Qt.AlignVBottom | Qt.AlignLeft
      text: collection && collection.name ? collection.name : ""
      color: colorFont
      font.pixelSize: fontSizeGameDetailsSubheader
      font.family: generalFont.name
      font.capitalization: Font.AllUppercase
      lineHeight: 0.9
    }

    // Game title
    Text {
      color: colorFontStrong
      text: game && game.title ? game.title : ""
      font.pixelSize: fontSizeGameDetailsHeader
      font.family: headerFont.name
      font.bold: true
      Layout.alignment: Qt.AlignVTop | Qt.AlignLeft
      Layout.fillWidth: true
      Layout.preferredWidth: parent.width
      elide: Text.ElideRight
    }

    // Meta boxes
    RowLayout {
      spacing: spacingStd
      MetaBox { metaTitle: 'PLAYERS'; metaContent: game && game.players ? game.players : "" }
      MetaBox { metaTitle: 'RATING'; metaContent: game && game.rating ? `${Math.round(game.rating * 100)}%`  : "N/A"}
      MetaBox { metaTitle: 'RELEASED'; metaContent: game && game.releaseYear > 0 ? game.releaseYear : "N/A" }
      MetaBox { metaTitle: 'GENRE'; metaContent: game && game.genre ? game.genre : "N/A" }
      MetaBox { metaTitle: 'DEVELOPER'; metaContent: game && game.developer ? game.developer : "N/A" }
      MetaBox { metaTitle: 'PUBLISHER'; metaContent: game && game.publisher ? game.publisher : "N/A" }
      MetaBox { metaTitle: 'LAST PLAYED'; metaContent: game ? Utils.formatLastPlayed(game.lastPlayed) : "" }
      MetaBox { metaTitle: 'TIME PLAYED'; metaContent: game ? Utils.formatPlayTime(game.playTime) : "" }
    }

    // Game description
    Item {
      Layout.fillWidth: true
      Layout.fillHeight: true
      Layout.topMargin: spacingStd

      Text {
        font.pixelSize: fontSizeRegular
        font.family: generalFont.name
        text: game && game.description ? game.description : ""
        wrapMode: Text.WordWrap
        elide: Text.ElideRight
        color: colorFont
        anchors.fill: parent
      }
    }

    // Video
    Item {
      id: screenshotBox
      height: vpx(400)
      Layout.fillWidth: true

      Item {
        id: screenshot

        anchors {
          fill: parent
          horizontalCenter: parent.horizontalCenter
          verticalCenter: parent.verticalCenter
          bottomMargin: marginVertGamelistScreen
        }

        GamePreviewItem {
          anchors.fill: parent

          game: gameDetails.game
          optionsView: mainSwitcher.optionsView
        }
      }
    }
  }
}
