//
//  ViewController.swift
//  rakutenTableTest
//
//  Created by 笹倉一也 on 2021/08/28.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource, UITextFieldDelegate {
  

    var recips = [SerchBookKList]()

//    テキストフィールドに入れたワードを入れる箱
    var words:String = ""
        
    
    private let cellId = "cellId"
    
    
    @IBOutlet weak var tableviewTest: UITableView!
    @IBOutlet weak var textField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

 
        
        tableviewTest.delegate = self
        tableviewTest.dataSource = self
        textField.delegate = self
        
//        tableviewTest.register(TableViewCell.self, forCellReuseIdentifier: cellId)
        
        tableviewTest.register(UINib(nibName: "testTableViewCell", bundle: nil), forCellReuseIdentifier: cellId)
        
//        getRApi()

    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {

            // キーボードを隠す

            textField.resignFirstResponder()
            
            let itemString = textField.text
            
            self.words = itemString?.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""

            
            getRApi()
            
            print(self.words)


            return true
        }


    
    
    private func getRApi(){

        
        guard let url = URL(string:"https://app.rakuten.co.jp/services/api/BooksDVD/Search/20170404?format=json&artistName=\(words)&booksGenreId=003&applicationId=1024730205059605378")

           else {return}

           let task = URLSession.shared.dataTask(with: url) { (data, response, err)in
               if let err = err {
                   print("情報の取得に失敗しました。:", err)
                   return
               }
               if let data = data{
                   do{
                       let resultList = try JSONDecoder().decode(SerchBookKList.self, from: data)
                       self.recips = [resultList]

                       DispatchQueue.main.async {
                                              self.tableviewTest.reloadData()
                                          }
                    print("json: ", resultList)

                   }catch(let err){
                        print("情報の取得に失敗しました。:", err)

                   }
               }
           }
           task.resume()
       }
   
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           return 80
       }
    
  
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        if (recips.count == 0) {
                          return recips.count
                      } else {
                        return recips[0].Items?.count ?? 0
            }
    }



    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! testTableViewCell
        
//            cell.recip = recips[0].Items?[indexPath.row].Item

//            return cell
        
        
        
        
//        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
//
        cell.recip = recips[0].Items?[indexPath.row].Item

        return cell

    }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(recips[0].Items?[indexPath.row].Item ?? 0)
        
        
        }

}

