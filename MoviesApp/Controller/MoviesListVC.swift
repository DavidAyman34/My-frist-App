//
//  MoviesListVC.swift
//  MoviesApp
//
//  Created by Divo Ayman on 2/25/20.
//  Copyright © 2020 Divo Ayman. All rights reserved.
//

import UIKit
import SQLite
class MoviesListVC: UIViewController {
    @IBOutlet weak var segmented: UISegmentedControl!
    @IBOutlet weak var titleN: UILabel!
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    var myMedia = [MediaRsponse]( )
    var dataSaved = UserDefaultsManager.shared().getSavedData()
    var serText: String?
    var segSelect: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        SQLiteURl.openDataBase()
        dataSaved.isLogin = true
        UserDefaultsManager.shared().saveDataFor(user: dataSaved)
        tableview.dataSource = self
        tableview.delegate = self
        tableview.estimatedRowHeight = 44
        tableview.rowHeight = UITableView.automaticDimension
        let tableNib = UINib(nibName: TableViewNib.tableNibIdentifier, bundle: nil)
        tableview.register(tableNib, forCellReuseIdentifier: Cells.cellIdentifier)
        searchBar.delegate = self
        SQLiteManager.openDataBase()
        SQLiteManager.createTable()
        historyData()
        tableview.tableFooterView = UIView()
    }
    func historyData( ){
        let result = SQLiteManager.returnDataSaved()
        self.myMedia = result
        self.tableview.reloadData()
    }
    func bindData( ){
        APIManager.loadMedia(mediaType: segSelect ?? "music", criteria: serText ?? "enter search"){ (error, media) in
            if let error = error {
                print(error.localizedDescription)
            }
            else{
                if let media = media {
                    self.myMedia = media
                    self.tableview.reloadData()
                }
            }
        }
    }
    @IBAction func segmentedPath(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            titleN.text = "Music"
            segSelect = mediaType.music.rawValue
        case 1:
            titleN.text = "TvShow"
            segSelect =  mediaType.tvShow.rawValue
        case 2:
            titleN.text = "Movie"
            segSelect = mediaType.movie.rawValue
        default:
            segSelect = mediaType.music.rawValue
        }
    }
    @IBAction func goSearch(_ sender: UIButton) {
        bindData()
      searchBar.resignFirstResponder()
      
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar){
        bindData()
        searchBar.endEditing(true)
    }
    @IBAction func deleteHistoryBtn(_ sender: Any) {
        let  alertError = UIAlertController(title: "Clear", message: "Do you wanna clear History" , preferredStyle: .alert)
        alertError.addAction(UIAlertAction(title:"ok", style: .default, handler: { (action: UIAlertAction!) in
            SQLiteManager.deleteHistory()
            self.myMedia = [ ]
            self.tableview.reloadData()
        }))
        alertError.addAction(UIAlertAction(title:"Cancle", style: .default, handler: nil))
        self.present(alertError, animated: true)
    }
}
extension MoviesListVC: UITableViewDataSource, UITableViewDelegate,UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        serText = searchText
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myMedia.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let MoviesDetil = UIStoryboard.init(name:Storybords.main, bundle: nil).instantiateViewController(withIdentifier: "MoviesDetil") as! MoviesDetil
        MoviesDetil.media = myMedia[indexPath.row]
        MoviesDetil.play(prev:  myMedia[indexPath.row].previewUrl)
        self.present(MoviesDetil, animated: true, completion: nil)
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cells.cellIdentifier , for: indexPath)  as! TableNib
        cell.configureCell(media: myMedia[indexPath.row])
        cell.animateCell()
        return cell
    }
    
    
}

