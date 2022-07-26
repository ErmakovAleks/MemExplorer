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
    
    let provider: MemesDataProvidable & ImageTaskHandlerGettable
    private var memesArray = [Meme]()
    private var imagesArray = [UIImage]()
    
    // MARK: -
    // MARK: Initializators
    
    init(provider: MemesDataProvidable & ImageTaskHandlerGettable) {
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
                self?.refresh(memes: memes)
            case .failure(_):
                print("Incorect response from server!")
            }
        }
    }
    
    func refresh(memes: [Meme]) {
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
        self.registerTableViewCell()
        self.memes()
    }
    
    private func registerTableViewCell() {
        self.rootView?.tableView?.registerCell(cellClass: MemeDescriptionCell.self)
    }
    
    private func configure(cell: MemeDescriptionCell?, with image: UIImage, and url: URL) {
        if url == cell?.url {
            DispatchQueue.main.async {
                cell?.removeSpinner()
                image.scalePreservingAspectRatio(targetSize: 300, handler: { img in
                    DispatchQueue.main.async {
                        cell?.setCell(image: img)
                    }
                })
                
                cell?.processStar = { [weak self] cell in
                    guard
                        let cell = cell as? MemeDescriptionCell,
                        let indexPath = self?.rootView?.tableView?.indexPath(for: cell)
                    else { return }
                    self?.mark(by: indexPath)
                }
            }
        }
    }
    
    private func mark(by indexPath: IndexPath) {
        self.inverseIsFavorite(by: indexPath)
        self.reorderList()
        //self.rootView?.tableView?.reloadRows(at: [indexPath], with: .automatic)
        //self.rootView?.tableView?.reloadData()
        self.reload(tableView: self.rootView?.tableView)
    }
    
    private func inverseIsFavorite(by indexPath: IndexPath) {
        self.memesArray[indexPath.row].isFavorite = !self.memesArray[indexPath.row].isFavorite
    }
    
    private func reorderList() {
        let favorites = self.memesArray.filter { $0.isFavorite }
        let unFavorites = self.memesArray.filter { !$0.isFavorite }
        self.memesArray = favorites + unFavorites
    }
    
    private func reload(tableView: UITableView?) {
        guard var contentOffset = tableView?.contentOffset else { return }
        contentOffset.y += 150
        tableView?.reloadData()
        tableView?.layoutIfNeeded()
        tableView?.setContentOffset(contentOffset, animated: false)
    }
    
    // MARK: -
    // MARK: UITableViewDataSource, UITableViewDelegate
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withCellClass: MemeDescriptionCell.self, for: indexPath)       
        cell.addSpinner()
        cell.memeDescriptionLabel?.text = self.memesArray[indexPath.row].name
        cell.isFavorite = self.memesArray[indexPath.row].isFavorite
        
        let url = self.memesArray[indexPath.row].url
        cell.url = url
        self.provider.image(
            for: url,
            resumed: true,
            handler: { [weak cell] result in
                switch result {
                case .success(let image):
                    self.configure(cell: cell, with: image, and: url)
                case .failure(let error):
                    print(error)
                }
            },
            taskHandler: { [weak cell] task in
                cell?.onReuse = {
                    task?.cancel()
                }
            })
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}
