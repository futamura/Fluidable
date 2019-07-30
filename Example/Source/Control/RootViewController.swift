//
//  RootViewController.swift
//  Example
//
//  Created by kojirof on 2019/06/29.
//  Copyright © 2019 Gumob. All rights reserved.
//

import Foundation
import UIKit
import Fluidable

/* IMPORTANT: 🌊 Conform to `Fluidable` protocol */
class RootViewController: UICollectionViewController, Fluidable {
    var selectedIndex: Int?
    weak var selectedCell: RootBaseCollectionCell? {
        guard let index: Int = self.selectedIndex else { return nil }
        return self.collectionView.cellForItem(at: IndexPath(row: index, section: 0)) as? RootBaseCollectionCell
    }
    weak var selectedImage: UIImage? {
        return self.selectedCell?.contentView.toImage()
    }
    var selectedFrame: (frame: CGRect, transform: CATransform3D)? {
        guard let cell: RootBaseCollectionCell = self.selectedCell else { return nil }
        let frame: CGRect = cell.contentView.convert(cell.contentView.frame, to: UIApplication.shared.keyWindow)
        let transform: CATransform3D = cell.layer.presentation()?.transform ?? cell.layer.transform
        return (frame: frame, transform: transform)
    }

    lazy var optionView: RootOptionView = {
        let v: RootOptionView = UINib.instantiate(nibName: "RootOptionView")
        v.center = self.view.center
        self.view.addSubview(v)
        return v
    }()

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        Logger()?.log("👑🛠", [])
        /* IMPORTANT: 🌊 Enable `Fluidable`. See implementation in `RootViewController+Fluidable.swift` */
        self.fluidDelegate = self
    }

    override func viewDidLoad() {
        Logger()?.log("👑💥", [])
        super.viewDidLoad()
        /* NOTE: Setup collection view */
        self.collectionView.backgroundColor = .white
        self.collectionView.contentInset = UIEdgeInsets(top: ExampleConst.collectionTopMargin, left: ExampleConst.collectionBottomMargin,
                                                        bottom: ExampleConst.collectionBottomMargin, right: ExampleConst.collectionRightMargin)
        if let layout: AlignedCollectionLayout = collectionView.collectionViewLayout as? AlignedCollectionLayout { layout.delegate = self }
        /* NOTE: Register nib */
        self.collectionView.register(cellType: RootImageCell.self)
        self.collectionView.register(cellType: RootImageTextCell.self)
        self.collectionView.register(cellType: RootTableCell.self)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
}

extension RootViewController {
    @IBAction func didTapOptionButton(_ sender: UIBarButtonItem) {
        Logger()?.log("👑👆", [])
        self.optionView.toggle()
    }

    func didTapCell(index: Int) {
        guard let model: RootModel = RootModel(rawValue: index) else { return }
        Logger()?.log("👑👆", [])
        /* NOTE: Set `selectedIndex` value for the scale transition */
        self.selectedIndex = index
        /* NOTE: Present destination view controller */
        self.present(model.instantiate(), animated: true)
        /* NOTE: Reset cell transform */
        self.collectionView.cellForItem(at: IndexPath(item: index, section: 0))
    }
}
