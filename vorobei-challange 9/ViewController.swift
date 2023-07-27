//
//  ViewController.swift
//  vorobei-challange 9
//
//  Created by Alexey Voronov on 27.07.2023.
//

import UIKit

class SnapCenterLayout: UICollectionViewFlowLayout {
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        guard let collectionView = collectionView else { return super.targetContentOffset(forProposedContentOffset: proposedContentOffset, withScrollingVelocity: velocity) }
        let parent = super.targetContentOffset(forProposedContentOffset: proposedContentOffset, withScrollingVelocity: velocity)
        
        let itemSpace = itemSize.width + minimumInteritemSpacing
        
        let defaultTarget = super.targetContentOffset(forProposedContentOffset: proposedContentOffset, withScrollingVelocity: velocity)
        
        
        
        let nearestPageOffset = CGFloat(Int(defaultTarget.x / itemSpace)) * itemSpace - collectionView.layoutMargins.left + sectionInset.left
        
        print(velocity, nearestPageOffset, parent.x, proposedContentOffset)
        
        return CGPoint(x: nearestPageOffset,
                       y: parent.y)
    }
}


class ViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        guard let layout = collectionView.collectionViewLayout as? SnapCenterLayout else { return }
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 300, height: collectionView.bounds.height)
        layout.sectionInset = UIEdgeInsets(top: 0, left: collectionView.layoutMargins.left, bottom: 0, right: 300)
    }
}


extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.layer.cornerRadius = 10
        cell.backgroundColor = .lightGray
        return cell
    }
}
