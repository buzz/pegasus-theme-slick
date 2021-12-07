import QtQuick 2.15
import QtMultimedia 5.15
import QtGraphicalEffects 1.12

Item {
  property var game
  required property bool optionsView

  property bool gamelistView: gamelistScreen.focus

  property bool steam: false
  property bool hasImage: getImageSource().length

  onOptionsViewChanged: {
    if (videoPreviewLoader.item) {
      if (optionsView)
        videoPreviewLoader.item.pause();
      else
        videoPreviewLoader.item.play();
    }
  }

  onGameChanged: {
    videoPreviewLoader.sourceComponent = undefined;
    if (gamelistView) {
      showImage();
      timerHideImage.stop();
      timerVideoDelay.restart();
    }
  }

  onGamelistViewChanged: {
    if (gamelistView) {
      videoPreviewLoader.sourceComponent = undefined;
      timerVideoDelay.restart();
    } else {
      videoPreviewLoader.sourceComponent = undefined;
      showImage();
      timerHideImage.stop();
      timerVideoDelay.stop();
    }

    if (collection && collection.shortName == "steam") {
      steam = true
    } else {
      steam = false
    }
  }

  // Small delay to avoid loading videos during scrolling
  Timer {
    id: timerVideoDelay
    interval: 500
    onTriggered: {
      if (game && game.assets && game.assets.videos && game.assets.videos.length) {
        videoPreviewLoader.sourceComponent = videoPreviewWrapper;
        if (hasImage) {
          timerHideImage.restart();
        } else {
          hideImage();
        }
      }
    }
  }

  Timer {
    id: timerHideImage
    interval: durationPlayVideo
    onTriggered: hideImage()
  }

  function showImage() {
    screenshot.opacity = 1;
    videoPreviewLoader.opacity = 0;
  }

  function hideImage() {
    screenshot.opacity = 0;
    videoPreviewLoader.opacity = 1;
  }

  function getImageSource() {
    if (game && game.assets) {
      if (steam && game.assets.logo)
        return game.assets.logo;
      if (game.assets.screenshots[0])
        return game.assets.screenshots[0];
      if (game.assets.poster)
        return game.assets.poster;
    }
    return "";
  }

  // Screenshot
  Image {
    id: screenshot

    z: 3
    anchors.fill: parent

    asynchronous: true
    visible: hasImage

    smooth: true

    source: getImageSource()

    sourceSize { width: 512; height: 512 }
    fillMode: Image.PreserveAspectCrop

    Behavior on opacity {
      PropertyAnimation {
        duration: durationLong
        easing.type: Easing.InOutCubic
      }
    }
  }

  // Video preview
  Component {
    id: videoPreviewWrapper

    Video {
      source: game.assets.videos.length ? game.assets.videos[0] : ""
      anchors.fill: parent
      fillMode: VideoOutput.PreserveAspectFit
      volume: 0.3
      loops: MediaPlayer.Infinite
      autoPlay: true
    }
  }

  Loader {
    id: videoPreviewLoader
    asynchronous: true
    anchors.fill: parent
    opacity: 0

    Behavior on opacity {
      PropertyAnimation {
        duration: durationLong
        easing.type: Easing.InOutCubic
      }
    }
  }
}
