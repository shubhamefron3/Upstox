//
//  HomePageViewController.swift
//  Upstox
//
//  Created by MacBook on 15/11/24.
//

import UIKit

final class HomePageViewController: UIViewController {
    
    //MARK: Outlets
    @IBOutlet private(set) weak var stockHoldingTableView: UITableView!
    @IBOutlet private(set) weak var barStacksContainer: UIView!
    @IBOutlet private(set) weak var spinner: UIActivityIndicatorView!
    @IBOutlet private weak var hideShowStack: UIStackView!
    @IBOutlet private weak var currentValueLabel: UILabel!
    @IBOutlet private weak var totalInvestmentLabel: UILabel!
    @IBOutlet private weak var totalPnLabel: UILabel!
    @IBOutlet private weak var pnLStack: UIView!
    @IBOutlet private weak var pnLabel: UILabel!
    @IBOutlet  weak var upDownButton: UIButton!
    //MARK: Properties
    private(set) var viewModel: HomePageViewModelTypeProtocol?
    private var isOpen = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hideShowStack.isHidden = true
        barStacksContainer.isHidden = true
        setupSpinner()
        setupTableView()
        viewModel = HomePageViewModelClass(delegate: self)
        viewModel?.input.getStockHoldingData()
        barStacksContainer.roundCorners(corners: [.topLeft,.topRight], radius: 12)
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapOnListView))
        pnLStack.addGestureRecognizer(tap)
    }
    
    private func setupSpinner(){
        spinner.hidesWhenStopped = true
        spinner.startAnimating()
    }
    
    private func setupTableView(){
        stockHoldingTableView.delegate = self
        stockHoldingTableView.dataSource = self
        stockHoldingTableView.register(UINib(nibName: "stockHoldingTableViewCell", bundle: nil), forCellReuseIdentifier: "stockHoldingTableViewCell")
    }
    
    private func togglePnLList(){
        isOpen.toggle()
        upDownButton.setImage(UIImage(named: isOpen ? "dropdown" :"dropup"), for: .normal)
        
        UIView.animate(withDuration: 0.3, animations: {
            self.hideShowStack.alpha = !self.isOpen ? 0 : 1
        }, completion: { [weak self] _ in
            if let self = self {
                self.hideShowStack.isHidden = !self.isOpen
            }
        })
    }
    
    @objc private  func tapOnListView(){
        togglePnLList()
    }
    
    @IBAction private  func upDownButtonAction(_ sender: UIButton) {
        togglePnLList()
    }
    
    //MARK: Public function
    /// setting up values for the list caontained in the p&L barlist
    func setupBarValues() {
        currentValueLabel.text = "₹ \(viewModel?.stockHoldingsData?.currentValue ?? 0)"
        totalInvestmentLabel.text = "₹ \(viewModel?.stockHoldingsData?.totalInvestment ?? 0)"
        totalPnLabel.text = "₹ \(viewModel?.stockHoldingsData?.todayPNL ?? 0)"
        pnLabel.text = "₹ \(viewModel?.stockHoldingsData?.totalPNL ?? 0)"
        
        currentValueLabel.textColor = Utilities.setupTextColor(textValue: (viewModel?.stockHoldingsData?.currentValue ?? 0))
        
        totalInvestmentLabel.textColor = Utilities.setupTextColor(textValue: (viewModel?.stockHoldingsData?.totalInvestment ?? 0))
        
        totalPnLabel.textColor = Utilities.setupTextColor(textValue: (viewModel?.stockHoldingsData?.todayPNL ?? 0))
        
        pnLabel.textColor = Utilities.setupTextColor(textValue: (viewModel?.stockHoldingsData?.totalPNL ?? 0))
        
    }
}



