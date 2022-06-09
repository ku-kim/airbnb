//
//  Histogram.swift
//  AirbnbApp
//
//  Created by dale on 2022/06/07.
//

import Foundation
import UIKit
import SnapKit

final class HistogramView: UIView {
    
    private var cgPoint: [CGPoint] = []
    private let path = UIBezierPath()
    private let bezierLayer = CAShapeLayer()
    
    override func draw(_ rect: CGRect) {
        path.lineJoinStyle = .round
        
        let lineWidth = rect.width / CGFloat(cgPoint.count)
        
        let coords = cgPoint.map {
            getCoordinate(rect, point: $0)
        }
        
        coords.forEach { point in
            path.move(to: CGPoint(x: point.x + lineWidth / 2, y: rect.width))
            path.addLine(to: CGPoint(x: point.x + lineWidth / 2, y: point.y))
        }
        
        path.close()
        
        bezierLayer.path = path.cgPath
        bezierLayer.lineWidth = floor(lineWidth / 20) * 10
        bezierLayer.strokeColor = UIColor.black.cgColor
        layer.mask = bezierLayer
    }
    
    func setPath(points: [CGPoint]) {
        cgPoint = points
    }
    
    private func getCoordinate(_ rect: CGRect, point: CGPoint) -> CGPoint {
        let coordX = rect.width * point.x
        let coordY = rect.height - (rect.height * point.y)
        return CGPoint(x: coordX, y: coordY)
    }
}
