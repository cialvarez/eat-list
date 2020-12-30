//
//  SimpleCarouselItemView.swift
//  EatList
//
//  Created by Christian Alvarez on 12/29/20.
//

import UIKit

class SimpleCarouselItemView: UIControl, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    fileprivate var dataSource = [String]()
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.backgroundColor = UIColor.clear.withAlphaComponent(0)
            collectionView.register(SimpleCarouselItemCell.self)
        }
    }
    
    @IBAction func selectedCells(_ sender: Any) {
        sendActions(for: .touchUpInside)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        viewLoadFromNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        viewLoadFromNib()
    }
    
    private func viewLoadFromNib() {
        guard let view = R.nib.simpleCarouselItemView.firstView(owner: self) else {
            return
        }
        
        addSubview(view)
        view.frame = self.bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
}

extension SimpleCarouselItemView {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard dataSource.count > indexPath.row else { return UICollectionViewCell() }
        let cell = collectionView.dequeueReusableCell(of: SimpleCarouselItemCell.self, for: indexPath)
        cell.setup(name: dataSource[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedCells(self)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if dataSource.count > indexPath.row {
            return  SimpleCarouselItemCell
                .calcSize(forName: dataSource[indexPath.row])
        }
        return CGSize()
    }
}

extension SimpleCarouselItemView {
    
    func updateDataSource(with data: [String]) {
        activityIndicator.stopAnimating()
        dataSource = data
        collectionView.reloadData()
    }
    
    func resetData() {
        activityIndicator.startAnimating()
        dataSource = [String]()
        collectionView.reloadData()
    }
}
