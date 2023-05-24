//
//  ItemListViewModel.swift
//  InterviewApp
//
//  Created by DB-MBP-004 on 24/05/23.
//

import Foundation
import RxCocoa

class ItemListViewModel {
    var tableData: BehaviorRelay<[String]>
    init(data: [String]) {
        self.tableData = BehaviorRelay<[String]>(value: data)
    }
}
