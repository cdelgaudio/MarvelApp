//
//  ComicListViewController.swift
//  MarvelApp
//
//  Created by Carmine Del Gaudio on 07/04/2020.
//  Copyright © 2020 Carmine Del Gaudio. All rights reserved.
//

import UIKit

class ComicListViewController: UIViewController {
  
  // MARK: Constants
  
  private enum Constants {
    static let spacing: CGFloat = 5
  }
  
  // MARK: Properties

  private let collectionView: UICollectionView = {
    let flowLayout = UICollectionViewFlowLayout()
    flowLayout.minimumLineSpacing = Constants.spacing
    flowLayout.minimumInteritemSpacing = Constants.spacing
    flowLayout.scrollDirection = .vertical
    return .init(frame: .zero, collectionViewLayout: flowLayout)
  }()
  
  private let viewModel: ComicListViewModel
  
  private let state: ImmutableBinder<ComicListViewModel.State>
  
  private var disposeBag: [Disposable] = []
  
  // MARK: Init
  
  init(viewModel: ComicListViewModel, state: ImmutableBinder<ComicListViewModel.State>) {
    self.viewModel = viewModel
    self.state = state
    super.init(nibName: nil, bundle: nil)
    makeView()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: LifeCycle

  override func viewDidLoad() {
    super.viewDidLoad()
    makeBindings()
    viewModel.start()
  }
  
  // MARK: Bindings
  
  private func makeBindings() {
    let dispose = state.bind(on: .main) { [weak self] state in
      switch state {
      case .failed(let message):
        self?.presentAlert(message: message)
      case .loading:
        // TODO: Loading screen
        break
      case .completed:
        self?.collectionView.reloadData()
      }
    }
    disposeBag.append(dispose)
  }
  
  // MARK: View

  private func makeView() {
    title = "Comic List"
    view.backgroundColor = .white
    makeCollectionView()
  }
  
  private func makeCollectionView() {
    collectionView.delegate = self
    collectionView.dataSource = self
    collectionView.register(ComicItemCell.self)
    collectionView.backgroundColor = .clear
    view.addSubview(collectionView)
    collectionView.autoPinToSuperview()
  }
  
  // I like use the routing logic for the flow and left the alert presentation inside the controller
  private func presentAlert(message: String = "Generic Error") {
    let alert = UIAlertController(
      title: "Error!",
      message: message,
      preferredStyle: .alert
    )
    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
    self.present(alert, animated: true)
  }
  
}

// MARK: CollectionView

extension ComicListViewController: UICollectionViewDataSource {
  func collectionView(
    _ collectionView: UICollectionView,
    numberOfItemsInSection section: Int
  ) -> Int {
    switch state.value {
    case .completed(let comicList):
      return comicList.count
    default:
      return 0
    }
  }
  
  func collectionView(
    _ collectionView: UICollectionView,
    cellForItemAt indexPath: IndexPath
  ) -> UICollectionViewCell {
    switch state.value {
    case .completed(let comicList):
      let cell: ComicItemCell = collectionView.dequeue(for: indexPath)
      cell.configure(viewModel: comicList[indexPath.row])
      return cell
    default:
      fatalError("Cell not valid")
    }
  }
}

extension ComicListViewController: UICollectionViewDelegate {
  func collectionView(
    _ collectionView: UICollectionView,
    didSelectItemAt indexPath: IndexPath
  ) {
    viewModel
  }
}

extension ComicListViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    sizeForItemAt indexPath: IndexPath
  ) -> CGSize {
    let width = (collectionView.bounds.width - Constants.spacing) / 2
    return CGSize(width: width, height: width * 1.5)
  }
}
