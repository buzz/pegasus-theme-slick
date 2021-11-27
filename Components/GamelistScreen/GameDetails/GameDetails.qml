import QtQuick 2.15
import QtQuick.Layouts 1.11
import "utils.js" as Utils

Item {
  id: gameDetails

  required property var game

  ColumnLayout {
    anchors {
      fill: parent
      leftMargin: vpx(40)
      topMargin: vpx(40)
    }

    // Collection name
    Text {
      id: collectionName

      Layout.alignment: Qt.AlignVBottom | Qt.AlignLeft
      text: collection.name || "Not Found"
      color: colorFont
      font.pixelSize: vpx(32)
      font.family: headerFont.name
      font.capitalization: Font.AllUppercase
      lineHeight: 0.85
    }

    // Game title
    Text {
      color: "white"
      text: game.title
      font.pixelSize: vpx(56)
      font.family: headerFont.name
      Layout.alignment: Qt.AlignVTop | Qt.AlignLeft
      Layout.fillWidth: true
      Layout.preferredWidth: parent.width
      elide: Text.ElideRight
    }

    // Meta boxes
    RowLayout {
      spacing: vpx(10)
      MetaBox { metaTitle: 'PLAYERS'; metaContent: game.players }
      MetaBox { metaTitle: 'RATING'; metaContent: game.rating === "" ? "N/A" : Math.round(game.rating * 100) + '%'}
      MetaBox { metaTitle: 'RELEASED'; metaContent: Utils.formatDate(game.release) || "N/A" }
      MetaBox { metaTitle: 'GENRE'; metaContent: game.genreList[0] || "N/A" }
      MetaBox { metaTitle: 'DEVELOPER'; metaContent: game.developerList[0]  || "N/A" }
      MetaBox { metaTitle: 'PUBLISHER'; metaContent: game.publisherList[0] || "N/A" }
      MetaBox { metaTitle: 'LAST PLAYED'; metaContent: Utils.formatLastPlayed(game.lastPlayed) }
      MetaBox { metaTitle: 'TIME PLAYED'; metaContent: Utils.formatPlayTime(game.playTime) }
    }

    // Game description
    Item {
      width: parent.width
      Layout.fillHeight: true
      Layout.topMargin: vpx(10)

      Text {
        font.pixelSize: vpx(14)
        font.family: subheaderFont.name
        text: game.description
        wrapMode: Text.WordWrap
        elide: Text.ElideRight
        color: colorFont
        anchors {
          fill: parent
          horizontalCenter: parent.horizontalCenter
        }
      }
    }

    // Video
    Rectangle {
      id: screenshotBox
      height: vpx(400)
      width: parent.width
      color: "transparent"
      clip: false

      Item {
        // TODO: make width/height adhere to platform specific ratios so screenshots
        // and videos "fit nicely". Currently forced to 4/3.
        // 16:9 :: 608 x 342 (PSVita)
        // 3:2 :: 612:408 (GBA/GB)
        // 8:7 :: 608:532 (NES)
        id: screenshot
        width: vpx(504)
        height: vpx(378)

        anchors {
          horizontalCenter: parent.horizontalCenter
          verticalCenter: parent.verticalCenter
        }

        GamePreviewItem {
          anchors.fill: parent

          game: gameDetails.game
        }
      }
    }
  }
}