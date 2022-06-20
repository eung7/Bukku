//
//  Utilities.swift
//  Bukku
//
//  Created by 김응철 on 2022/06/19.
//

import Foundation
import UIKit

class Utilties {
    static func getHeightFromWidth(_ width: CGFloat) -> CGFloat {
        return (43 / 30) * width
    }
}

class BasePaddingLabel: UILabel {
    private var padding = UIEdgeInsets(top: 16.0, left: 16.0, bottom: 16.0, right: 16.0)

    convenience init(padding: UIEdgeInsets) {
        self.init()
        self.padding = padding
    }

    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: padding))
    }

    override var intrinsicContentSize: CGSize {
        var contentSize = super.intrinsicContentSize
        contentSize.height += padding.top + padding.bottom
        contentSize.width += padding.left + padding.right

        return contentSize
    }
}

