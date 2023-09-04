//
//  ViewController.swift
//  TaxApp
//
//  Created by Ngos on 2023/09/04.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    // UI要素のアウトレット接続
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var taxSegmentedControl: UISegmentedControl!
    @IBOutlet weak var taxIncludedPriceLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!

    // 税込価格と税率を保存するための配列
    var prices: [(price: Double, taxRate: Double)] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // テーブルビューのデリゲートとデータソースを設定
        tableView.delegate = self
        tableView.dataSource = self
        // テーブルビューのデリゲートとデータソースを設定
        tableView.delegate = self
        tableView.dataSource = self
        // セルの登録
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "PriceCell")
    }

    // 原価が変更されたときのアクション
    @IBAction func priceChanged(_ sender: UITextField) {
        updateTaxIncludedPrice()
    }

    // 税率が変更されたときのアクション
    @IBAction func taxRateChanged(_ sender: UISegmentedControl) {
        updateTaxIncludedPrice()
    }

    // 追加ボタンがタップされたときのアクション
    @IBAction func addButtonTapped(_ sender: UIButton) {
        if let price = Double(taxIncludedPriceLabel.text?.replacingOccurrences(of: "¥", with: "") ?? "") {
            let taxRate = taxSegmentedControl.selectedSegmentIndex == 0 ? 0.10 : 0.08
            prices.append((price: price, taxRate: taxRate))
            tableView.reloadData()
        }
    }

    // 合計ボタンがタップされたときのアクション
    @IBAction func totalButtonTapped(_ sender: UIButton) {
        // 画面遷移を実行
        performSegue(withIdentifier: "toTotal", sender: nil)
    }

    // 画面遷移の前にデータを渡す
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toTotal" {
            let totalVC = segue.destination as! TotalViewController
            totalVC.totalAmount = prices.reduce(0) { $0 + $1.price }
        }
    }

    // 税込価格を計算してラベルに表示するメソッド
    func updateTaxIncludedPrice() {
        // 1. TextFieldからの入力を取得
        if let price = Double(priceTextField.text ?? "") {
            // 2. 選択された税率を取得
            let taxRate = taxSegmentedControl.selectedSegmentIndex == 0 ? 0.10 : 0.08
            
            // 3. 税込価格を計算
            let taxIncludedPrice = price * (1 + taxRate)
            
            // 4. 計算された税込価格をLabelに表示
            taxIncludedPriceLabel.text = "¥" + String(format: "%.2f", taxIncludedPrice)
        } else {
            // 入力が無効な場合、Labelをクリア
            taxIncludedPriceLabel.text = "¥0.00"
        }
    }

    // テーブルビューの行数を返す
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return prices.count
    }

    // 各行の内容を設定
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PriceCell", for: indexPath)
        let priceInfo = prices[indexPath.row]
        cell.textLabel?.text = "¥\(priceInfo.price) (\(priceInfo.taxRate * 100)%)"
        return cell
    }
}
