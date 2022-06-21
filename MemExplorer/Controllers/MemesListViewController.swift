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
    private var memesArray = [Meme]()
    private var imagesArray = [UIImage]()
    
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
    
    func memes() {
        self.provider.memesList { [weak self] results in
            switch results {
            case .success(let memes):
                self?.refreshData(memes: memes)
            case .failure(_):
                print("Incorect response from server!")
            }
        }
    }
    
    func refreshData(memes: [Meme]) {
        DispatchQueue.main.async {
            self.memesArray += memes
            self.rootView?.tableView?.reloadData()
        }
    }
    
    // MARK: -
    // MARK: ViewController Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.rootView?.prepare()
        self.prepareTableView()
        self.registerTableViewCells()
        self.memes()
    }
    
    private func registerTableViewCells() {
        let cell = UINib(nibName: "MemeDescriptionCell", bundle: nil)
        self.rootView?.tableView?.register(cell, forCellReuseIdentifier: "memeDescriptionCell")
    }
    
    // MARK: -
    // MARK: UITableViewDataSource, UITableViewDelegate
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = self.rootView?.tableView?
            .dequeueReusableCell(withIdentifier: "memeDescriptionCell") as? MemeDescriptionCell
        {
            cell.memeDescriptionLabel?.text = self.memesArray[indexPath.row].name
            if let url = URL(string: self.memesArray[indexPath.row].url) {
                cell.setImage(url: url)
            }
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}
