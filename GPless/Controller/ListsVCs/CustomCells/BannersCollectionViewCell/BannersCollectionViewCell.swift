//
//  BannersCollectionViewCell.swift
//  GPless
//
//  Created by Khaled Bohout on 11/10/20.
//

import UIKit
import CollectionViewPagingLayout

class BannersCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var bannerImageView: UIImageView!

}

extension BannersCollectionViewCell: ScaleTransformView {
    
    var scaleOptions: ScaleTransformViewOptions {
        ScaleTransformViewOptions(
            minScale: 0.7,
            maxScale: 0.7,
            scaleRatio: 0,
            translationRatio: .zero,
            minTranslationRatio: .zero,
            maxTranslationRatio: .zero,
            shadowEnabled: true,
            rotation3d: .init(angle: .pi / 1.65, minAngle: -.pi / 3, maxAngle: .pi / 3, x: 0, y: -1, z: 0, m34: -0.000_5),
            translation3d: .init(translateRatios: (0.1, 0, -0.7), minTranslateRatios: (-0.1, 0, -3), maxTranslateRatios: (0.1, 0, 0))
        )
    }
}

