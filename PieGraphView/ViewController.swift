//
//  ViewController.swift
//  PieGraphView
//
//  Created by 今村京平 on 2021/11/06.
//

import UIKit

final class ViewController: UIViewController {
    private var graphView:PieGraphView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let params: [[String: Any]] = [
            ["value": 7, "color": UIColor.red],
            ["value": 5, "color": UIColor.blue],
            ["value": 8, "color": UIColor.green],
            ["value": 10, "color": UIColor.yellow]
        ]
        graphView = PieGraphView(frame: CGRect(x: 0, y: 30, width: 400, height: 400), params: params)
        self.view.addSubview(graphView)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        graphView.center = view.center
    }

    @IBAction private func start(sender: AnyObject) {
        graphView.startAnimating()
    }
}
