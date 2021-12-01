import SortFilterProxyModel 0.2

SortFilterProxyModel {
  required property string searchText
  required property int sortIndex

  // Defer as both callbacks may fire
  onSortIndexChanged: Qt.callLater(changed)
  onSearchTextChanged: Qt.callLater(changed)

  signal changed

  filters: [
    RegExpFilter {
      enabled: !!searchText
      caseSensitivity: Qt.CaseInsensitive
      roleName: "title"
      pattern: searchText
      syntax: RegExpFilter.FixedString
    }
  ]

  sorters: [
    RoleSorter {
      roleName: listModelSortGamelist.get(sortIndex).roleName
      sortOrder: Qt.AscendingOrder
      // priority: 1
    }
    // RoleSorter {
    //   enabled: listModelSortGamelist.get(sortIndex).roleName !== "sortBy"
    //   enabled: listModelSortGamelist.get(sortIndex).roleName !== "sortBy"
    //   roleName: "sortBy"
    //   sortOrder: Qt.AscendingOrder
    //   priority: 0
    // }
  ]
}
