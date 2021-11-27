import QtQuick 2.15
import QtQuick.Layouts 1.11
import QtGraphicalEffects 1.12

Rectangle {
  id: root
  property var game
  Item {
    id: gameDescriptionRect
    anchors {
      fill: parent
      horizontalCenter: parent.horizontalCenter
    }
  }
}
