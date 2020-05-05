import UIKit

class MediaListVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let searchBar = UISearchBar()
    var moviesArr = [MyMovie]()
    fileprivate let cellIdentifier = "MovieCell"
    let database = DatabaseManager.shared()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData(search: database.getCachedData())
        searchBar.sizeToFit()
        searchBar.delegate = self
        tableView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        showSearchBarButton(shouldShow: true)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 600
    }
    
    @IBAction func listDidChange(_ sender: UISegmentedControl) {
        
        switch sender.self.selectedSegmentIndex {
        case 1:
            Scope.scope = "music"
        case 2:
            Scope.scope = "tvShow"
        case 3:
            Scope.scope = "movie"
            
        default:
            Scope.scope = "all"
        }
    }
    
    func showSearchBarButton(shouldShow: Bool) {
        if shouldShow {
             navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(handleShowSearchBar))
        }
        else {
             navigationItem.rightBarButtonItem = nil
        }
    }
    func search(shouldShow: Bool) {
        showSearchBarButton(shouldShow: !shouldShow)
        searchBar.showsCancelButton = shouldShow
        navigationItem.titleView = shouldShow ? searchBar: nil
        
    }
    
   @objc func handleShowSearchBar() {
     search(shouldShow: true)
    searchBar.becomeFirstResponder()
    }
    
    func getData(search: String) {
        APIManager.loadMyMovies(search: search) { (error, movies) in
            if let error = error {
                print(error.localizedDescription)
                print("dataNo")
            } else if let movies = movies {
                self.moviesArr = movies
                self.tableView.reloadData()
                print("dataHere")
                
            }
        }
    }
}

extension MediaListVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moviesArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? MovieCell else {
            return UITableViewCell()
        }
        cell.configurecell(media: moviesArr[indexPath.row])
        cell.shadowAndBorderForCell(yourTableViewCell: cell)
        return cell
    }
    
  
    
}

extension MediaListVC: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else {return}
        database.updateCacheData(text: text)
        getData(search: text)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        search(shouldShow: false)
    }
    
    }







    


