//
//  MemesListViewController.swift
//  MemExplorer
//
//  Created by Александр Ермаков on 17.06.2022.
//

import UIKit

class MemesListViewController: UIViewController, RootViewGettable, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: -
    // MARK: Type Inferences
    
    typealias RootView = MemesListView
    
    // MARK: -
    // MARK: Variables
    
    let provider: MemesDataProvider
    
    // MARK: -
    // MARK: Initializators
    
    init(provider: MemesDataProvider) {
        self.provider = provider
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: -
    // MARK: Public functions
    
    func prepareTableView() {
        self.rootView?.tableView?.dataSource = self
        self.rootView?.tableView?.delegate = self
    }
    
    func memes() -> [Meme] {
        self.provider.memesList { [weak self] results in
            switch results {
            case .success(let memes):
                return memes
            case .failure(_):
                print("Incorect response from server!")
            }
        }
    }
    
    // MARK: -
    // MARK: ViewController Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.rootView?.prepare()
        self.prepareTableView()
    }
    
    // MARK: -
    // MARK: UITableViewDataSource, UITableViewDelegate
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = MemeDescriptionCell(style: .default, reuseIdentifier: nil)
        return cell
    }
}
