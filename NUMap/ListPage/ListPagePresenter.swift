
final class ListPagePresenter {
    private let blocksModel = BlocksModel()
    
    private let placesModel = PlacesModel()
    
    private var expandedSections = Set<Int>()
    
    var mode: PlacesMode = .blocks
    
    func getNumberOfSections() -> Int {
        switch mode {
        case .blocks:
            return blocksModel.blocks.count
        case .places:
            return placesModel.places.count
        }
    }
    
    func getNameForSection(_ section: Int) -> String {
        switch mode {
        case .blocks:
            return blocksModel.blocks[section]
        case .places:
            return placesModel.places[section]
        }
    }
    
    func getNumberOfRows(for section: Int) -> Int {
        switch mode {
        case .blocks:
            return blocksModel.blocksSubItems[section].count
        case .places:
            return placesModel.placesSubItems[section].count
        }
    }
    
    func getNameForRow(for index: Int, in section: Int) -> String {
        switch mode {
        case .blocks:
            return blocksModel.blocksSubItems[section][index]
        case .places:
            return placesModel.placesSubItems[section][index]
        }
    }
    
    func getRowPosition(for row: Int, in section: Int) -> CustomTableViewCell.CellPosition {
        let number = getNumberOfRows(for: section)
        if number == 1 {
            return .lastRow
        } else if row == number - 1 {
            return .lastRow
        }
        return .notLastRow
    }

    func isExpanded(_ section: Int) -> Bool {
        return expandedSections.contains(section)
    }
    
    func removeFromExpanded(_ section: Int) {
        expandedSections.remove(section)
    }
    
    func addToExpanded(_ section: Int) {
        expandedSections.insert(section)
    }
    
    func removeAllExpandedSections() {
        expandedSections.removeAll()
    }
}
