//
//  TotalViewController.swift
//  TaxApp
//
//  Created by Ngos on 2023/09/04.
//

import UIKit

class TotalViewController: UIViewController {

    // UI要素のアウトレット接続
    @IBOutlet weak var totalLabel: UILabel!

    // 合計金額を保存する変数
    var totalAmount: Double = 0.0

    override func viewDidLoad() {
        super.viewDidLoad()
        // 合計金額をラベルに表示
        totalLabel.text = String(format: "%.2f", totalAmount)
    }
}

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

