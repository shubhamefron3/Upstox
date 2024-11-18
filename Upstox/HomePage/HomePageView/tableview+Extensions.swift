//
//  tableview+Extensions.swift
//  Upstox
//
//  Created by MacBook on 18/11/24.
//

import Foundation
import UIKit

extension HomePageViewController: UITableViewDelegate, UITableViewDataSource {
    
    var userHolding: [UserHolding]? {
        return self.viewModel?.stockHoldingsData?.data?.userHolding
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userHolding?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let reusableCell = stockHoldingTableView.dequeueReusableCell(withIdentifier: "stockHoldingTableViewCell", for: indexPath) as? stockHoldingTableViewCell else {
            return UITableViewCell()
        }
        reusableCell.updateView(model: userHolding?[indexPath.row])
        return reusableCell
    }
}

extension HomePageViewController : HomePageViewModelOutputProtocol {
    
    func tableViewReload() {
        DispatchQueue.main.async { [weak self] in
            self?.barStacksContainer.isHidden = false
            self?.spinner.stopAnimating()
            self?.setupBarValues()
            self?.stockHoldingTableView.reloadData()
            
        }
    }
}

