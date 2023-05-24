//
//  ItemListViewController.swift
//  InterviewApp
//
//  Created by DB-MBP-004 on 24/05/23.
//

import UIKit
import RxSwift
import RxDataSources
import RxCocoa

class ItemListViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    typealias TableSection = SectionModel<String, String>
    typealias rxSwiftDataSource = RxTableViewSectionedReloadDataSource<TableSection>
    lazy var dataSource = tableviewDataSource()
    var viewModel : ItemListViewModel?
    private let disposeBag = DisposeBag()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel = ItemListViewModel(data: ["Chocolate", "Vanilla", "Strawberry"])
        self.tableView.register(UINib(nibName: "ItemListTableViewCell", bundle: nil), forCellReuseIdentifier: "ItemListTableViewCell")
        self.viewModel?.tableData
            .asDriver(onErrorJustReturn: [])
            .map {
                [TableSection(model: "", items: $0)]
            }
            .drive(self.tableView.rx.items(dataSource: self.dataSource))
            .disposed(by: disposeBag)
        
        
        // Do any additional setup after loading the view.
    }
    func tableviewDataSource() -> RxTableViewSectionedReloadDataSource<TableSection> {
        return RxTableViewSectionedReloadDataSource<TableSection>(
            configureCell: { (_, tableView, indexPath, data) -> UITableViewCell in
                if let cell = tableView.dequeueReusableCell(
                    withIdentifier: "ItemListTableViewCell",
                    for: indexPath
                ) as? ItemListTableViewCell {
                    cell.label.text = data
                    return cell
                }
                return UITableViewCell()
            })
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
