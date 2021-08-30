//
//  ViewController.swift
//  rakutenTableTest
//
//  Created by 笹倉一也 on 2021/08/28.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
  

    var recips = [SerchBookKList]()
    
    private let cellId = "cellId"
    
    
    @IBOutlet weak var tableviewTest: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

    
        tableviewTest.delegate = self
        tableviewTest.dataSource = self
        
        tableviewTest.register(TableViewCell.self, forCellReuseIdentifier: cellId)
        
        getRApi()

    }

    private func getRApi(){
           guard let url = URL(string: "https://app.rakuten.co.jp/services/api/BooksDVD/Search/20170404?format=json&artistName=%E5%8C%97%E9%87%8E%E6%AD%A6&booksGenreId=003&applicationId=1024730205059605378") else {return}

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
   
    
  
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        
        if (recips.count == 0) {
                          return recips.count
                      } else {
                        return recips[0].Items?.count ?? 0
            }
        
    
    }



    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)

        cell.textLabel?.text = recips[0].Items?[indexPath.row].Item?.title

        return cell

    }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(recips[0].Items?[indexPath.row].Item ?? 0)
        
        
        }

}

