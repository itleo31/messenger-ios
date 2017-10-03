//
//  DataChange.swift
//  JoltMate
//
//  Created by Khanh Pham on 8/27/17.
//  Copyright © 2017 Khanh Pham. All rights reserved.
//

import UIKit

enum CollectionDataChange {
    case reload([IndexPath])
    case insert([IndexPath])
    case update([IndexPath])
    case delete([IndexPath])
}

extension CollectionDataChange {
    var isReload: Bool {
        if case .reload = self {
            return true
        }
        return false
    }
    
    var order: Int {
        switch self {
        case .delete:
            return 1
        case .insert:
            return 2
        case .update:
            return 3
        default:
            return 0
        }
    }
}

extension UITableView {
    func performBatchUpdates(with changes: [CollectionDataChange]) {
        assert(!changes.isEmpty, "No changes to updates")
        
        if changes.contains(where: { $0.isReload }) {
            reloadData()
        } else {
            let sortedChanges = changes.sorted(by: { $0.order < $1.order })
            beginUpdates()
            
            // Delete
            sortedChanges.forEach({ (change) in
                switch change {
                case .delete(let items):
                    deleteRows(at: items, with: .automatic)
                case .insert(let items):
                    insertRows(at: items, with: .automatic)
                case .update(let items):
                    reloadRows(at: items, with: .automatic)
                default:
                    break
                }
            })
            
            endUpdates()
        }
    
    }
}

extension Array {
    func flatIndexPaths() -> [IndexPath] {
        return self.enumerated().map { IndexPath(row: $0.offset, section: 0) }
    }
}
