import QtQuick 2.8

Item {
  id: backgroundCollection

  property var currentCollection

  anchors.fill: parent

  Rectangle {
    color: colorBg
    anchors.fill: parent
  }

  Image {
    id: bgImg
    anchors.fill: parent
    visible: true
    asynchronous: true
    fillMode: Image.PreserveAspectFit
    source: "../../assets/backgrounds/%1.jpg".arg(parent.currentCollection.shortName)
    smooth: true
  }
}
