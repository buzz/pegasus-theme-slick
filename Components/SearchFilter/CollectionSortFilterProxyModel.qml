import SortFilterProxyModel 0.2

SortFilterProxyModel {
  required property string searchText
  required property int sortIndex

  // Defer as both callbacks may fire
  onSortIndexChanged: Qt.callLater(changed)
  onSearchTextChanged: Qt.callLater(changed)

  signal changed

  proxyRoles: [
    ExpressionRole {
      name: "company"
      expression: model.extra ? model.extra.company : ""
    },
    ExpressionRole {
      name: "year"
      expression: model.extra ? model.extra.year : ""
    }
  ]

  filters: [
    AnyOf {
      enabled: !!searchText

      RegExpFilter {
        caseSensitivity: Qt.CaseInsensitive
        roleName: "name"
        pattern: searchText
        syntax: RegExpFilter.FixedString
      }
      RegExpFilter {
        caseSensitivity: Qt.CaseInsensitive
        roleName: "company"
        pattern: searchText
        syntax: RegExpFilter.FixedString
      }
    }
  ]

  sorters: [
    RoleSorter {
      roleName: listModelSortCollections.get(sortIndex).roleName
      sortOrder: Qt.AscendingOrder
      priority: 1
    },
    RoleSorter {
      enabled: listModelSortCollections.get(sortIndex).roleName !== "sortBy"
      roleName: "sortBy"
      sortOrder: Qt.AscendingOrder
      priority: 0
    }
  ]
}
