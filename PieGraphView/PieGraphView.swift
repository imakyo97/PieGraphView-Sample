//
//  PieGraphView.swift
//  PieGraphView
//
//  Created by 今村京平 on 2021/11/06.
//

import Foundation
import UIKit

class PieGraphView: UIView {

    var params:[[String: Any]]!
    var safetyAngle:CGFloat!

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(frame: CGRect, params: [[String: Any]]) {
        super.init(frame: frame)
        self.params = params
        self.backgroundColor = UIColor.clear
        safetyAngle = -CGFloat(Double.pi / 2.0)
        createLabel()
    }

    private func createLabel() {
        let label = UILabel()
        label.frame = CGRect(x: 0, y: 0, width: 100, height: 45)
        label.text = "Label"
        label.textAlignment = .center
        label.center = center
        addSubview(label)
    }

    @objc func update(link: AnyObject){
        let angle = CGFloat(Double.pi * 2.0 / 100.0) // 1 % の時の割合
        safetyAngle += angle
        if(safetyAngle > CGFloat(Double.pi * 2)) {
            //終了
            link.invalidate()
        } else {
            self.setNeedsDisplay()
        }
    }

    func startAnimating(){
        let displayLink = CADisplayLink(target: self, selector: #selector(update(link:)))
        displayLink.add(to: RunLoop.current, forMode: RunLoop.Mode.common)
    }


    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code

        let context: CGContext = UIGraphicsGetCurrentContext()!
        var x: CGFloat = rect.origin.x
        x += rect.size.width / 2 // 幅の半分
        var y: CGFloat = rect.origin.y
        y += rect.size.height / 2 // 高さの半分
        var total: CGFloat = 0 // 合計
        for dic in params {
            let value = CGFloat(dic["value"] as! Int)
            total += value
        }

        var startAngle = -CGFloat(Double.pi / 2) // 12時の位置
        var endAngle: CGFloat = 0
        let radius: CGFloat = x
        for dic in params {
            let value = CGFloat(dic["value"] as! Int)
            endAngle = startAngle + CGFloat(Double.pi * 2) * (value / total)
            if(endAngle > safetyAngle) {
                endAngle = safetyAngle
            }
            let color:UIColor = dic["color"] as! UIColor

            context.move(to: CGPoint(x: x, y: y))
            context.addArc(center: CGPoint(x: x, y: y), radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: false)
//            context.addArc(center: CGPoint(x: x, y: y), radius: radius/2, startAngle: endAngle, endAngle: startAngle, clockwise: true)
            context.setFillColor(color.cgColor.components!)
            context.closePath()
            context.fillPath()
            startAngle = endAngle
        }
    }
}
