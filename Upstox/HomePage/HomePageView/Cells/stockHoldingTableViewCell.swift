//
//  stockHoldingTableViewCell.swift
//  Upstox
//
//  Created by MacBook on 16/11/24.
//

import UIKit

final class stockHoldingTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var holdingView: UIView!
    @IBOutlet private weak var symbolLabel: UILabel!
    @IBOutlet private weak var ltpValue: UILabel!
    @IBOutlet private weak var quantityLabel: UILabel!
    @IBOutlet private weak var closePriceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        holdingView.isHidden = true ///T1 Holidng: not getting data from server ,when to show n hide , to it's hidden rn
    }
    
    /// used to update the view of the cell
    /// - Parameter model: data  model contains the essential information to display on cell
    func updateView(model: UserHolding?) {
        symbolLabel.text = model?.symbol
        ltpValue.text = "₹ \(model?.ltp ?? 0)"
        quantityLabel.text = "\(model?.quantity ?? 0)"
        
        let pnL = Utilities.calulateProfitNLoss(model: model)
        closePriceLabel.text = "₹ \(pnL)"
        closePriceLabel.textColor = Utilities.setupTextColor(textValue: (pnL))
    }
}

