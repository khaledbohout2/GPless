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
            minScale: 0.55,
            maxScale: 0.55,
            scaleRatio: 0,
            translationRatio: .zero,
            minTranslationRatio: .zero,
            maxTranslationRatio: .zero,
            shadowEnabled: false,
            rotation3d: .init(angle: .pi / 4, minAngle: -.pi, maxAngle: .pi, x: 0, y: 1, z: 0, m34: -0.000_4 - 0.8 * 0.000_2 ),
            translation3d: .init(translateRatios: (0, 0, 0), minTranslateRatios: (0, 0, 1.25), maxTranslateRatios: (0, 0, 1.25))
        )
    }
}

