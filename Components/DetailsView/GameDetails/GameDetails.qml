import QtQuick 2.8
import QtQuick.Layouts 1.11
import "../utils.js" as Utils

Item {
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
      text: currentCollection.name || "Not Found"
      color: "#888888"
      font.pixelSize: vpx(32)
      font.family: headerFont.name
      font.capitalization: Font.AllUppercase
      lineHeight: 0.85
      Behavior on text {
        FadeAnimation {
          target: collectionName
        }
      }
    }

    // Game title
    // Rectangle {
    //   width: parent.width
    //   color: "blue"
    //   Layout.fillHeight: true
    //   // clip: true

    //   Text {
    //     text: "Foobar"
    //     font.pixelSize: vpx(20)
    //   }
    // }

    Text {
      color: "white"
      text: currentGame.title
      font.pixelSize: vpx(56)
      font.family: headerFont.name
      // fontSizeMode: Text.Fit
      // maximumLineCount: 2
      Layout.alignment: Qt.AlignVTop | Qt.AlignLeft
      Layout.fillWidth: true
      // Layout.fillHeight: true
      Layout.preferredWidth: parent.width
      // width: parent.width
      elide: Text.ElideRight
    }

    // Meta boxes
    RowLayout {
      spacing: vpx(10)
      MetaBox { metaTitle: 'PLAYERS'; metaContent: currentGame.players }
      MetaBox { metaTitle: 'RATING'; metaContent: currentGame.rating === "" ? "N/A" : Math.round(currentGame.rating * 100) + '%'}
      MetaBox { metaTitle: 'RELEASED'; metaContent: Utils.formatDate(currentGame.release) || "N/A" }
      MetaBox { metaTitle: 'GENRE'; metaContent: currentGame.genreList[0] || "N/A" }
      MetaBox { metaTitle: 'DEVELOPER'; metaContent: currentGame.developerList[0]  || "N/A" }
      MetaBox { metaTitle: 'PUBLISHER'; metaContent: currentGame.publisherList[0] || "N/A" }
      MetaBox { metaTitle: 'LAST PLAYED'; metaContent: Utils.formatLastPlayed(currentGame.lastPlayed) }
      MetaBox { metaTitle: 'TIME PLAYED'; metaContent: Utils.formatPlayTime(currentGame.playTime) }
    }

    // Game description
    Item {
      width: parent.width
      Layout.fillHeight: true
      Layout.topMargin: vpx(10)

      Text {
        font.pixelSize: vpx(14)
        font.family: subheaderFont.name
        text: currentGame.description
        wrapMode: Text.WordWrap
        elide: Text.ElideRight
        color: "#888888"
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

      Rectangle {
        // TODO: make width/height adhere to platform specific ratios so screenshots
        // and videos "fit nicely". Currently forced to 4/3.
        // 16:9 :: 608 x 342 (PSVita)
        // 3:2 :: 612:408 (GBA/GB)
        // 8:7 :: 608:532 (NES)
        id: screenshot
        width: vpx(504)
        height: vpx(378)
        color: "#00f3f3f3"

        anchors {
          horizontalCenter: parent.horizontalCenter
          verticalCenter: parent.verticalCenter
        }

        GameVideoItem {
          id: screenshotImage
          anchors { fill: parent }

          game: currentGame
          collectionView: collectionsView.focus
          detailView: detailsView.focus
          collectionShortName: currentCollection.shortName
        }
      }
    }
  }
}
