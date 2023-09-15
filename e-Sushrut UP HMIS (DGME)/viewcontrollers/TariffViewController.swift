
import UIKit
class TariffViewController: UIViewController,UISearchBarDelegate,UISearchControllerDelegate {
    
    

    @IBOutlet var tableView: UITableView!
    @IBOutlet weak var deptList_btn: UIButton!

    var allData=[TariffModel]()
    var arrData = [TariffModel]()
    let searchController=UISearchController(searchResultsController: nil)
    
    var hospCode:String!
    var arHospList=[HospListModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        deptList_btn.layer.cornerRadius = 8.0
        deptList_btn.layer.borderWidth = 1.5
        deptList_btn.layer.borderColor = UIColor.systemBlue.cgColor
        self.navigationItem.title = "Tariff Details"
        searchController.loadViewIfNeeded()
        showAlert()
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 55
        
        DispatchQueue.main.async {
            self.view.activityStartAnimating(activityColor: UIColor.white, backgroundColor: UIColor.black.withAlphaComponent(0.5))
        }
        getHospital()
        searchBarSetup()
       
    }
    @IBAction func deptAction_arrow(_ sender: Any) {
               
                    if let vc = self.storyboard?.instantiateViewController(withIdentifier: "HospListVC3")as? HospListVC3 {
                        vc.callBack = { (id: String,unit_name: String,hgstr_unit_name: String) in
                            self.hospCode = id
                            self.deptList_btn.setTitle(unit_name, for: .normal)
                            if(self.deptList_btn.title(for: .normal) != "Select Hospital"){
                                self.jsonParsing(hospCode: id)
                            }
                        }
                        vc.arrHospList = self.arHospList
                        vc.modalPresentationStyle = .automatic
                        self.present(vc, animated: true, completion: nil)
                     }
        
                }
    func getHospital(){
        DispatchQueue.main.async {
            self.view.activityStartAnimating(activityColor: UIColor.white, backgroundColor: UIColor.black.withAlphaComponent(0.5))
        }
        let url2 = ServiceUrl.teleconsultancyHospitalList

        let url = URL(string: url2)

       // print("url "+url2)
        URLSession.shared.dataTask(with: url!) { [self] (data, response, error) in
            guard let data = data else { return }
            do{
                let json = try JSON(data:data)
                if json.count == 0{
                    self.alert(title: "Info",message: "Hospital not found!")
                }
                else{
                for arr in json.arrayValue{
                    self.arHospList.append(HospListModel(json: arr))
                }
                    

                }
                DispatchQueue.main.async {
                    self.view.activityStopAnimating()
                    self.deptList_btn.setTitle(self.arHospList[0].hospName, for: .normal)
                    self.jsonParsing(hospCode: self.arHospList[0].hospCode)
                }
                
            }catch{
                DispatchQueue.main.async {
                    self.view.activityStopAnimating()
                }
                print("error"+error.localizedDescription)
            }
            }.resume()
    }
    func jsonParsing(hospCode:String){
        self.allData.removeAll()
        self.arrData.removeAll()
        let url = URL(string: "\(ServiceUrl.tariffUrl)\(hospCode)")
        print("\(ServiceUrl.tariffUrl)\(hospCode)")
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            guard let data = data else {
                return }
            do{
                let json = try JSON(data:data)
                print(data)
                for arr in json.arrayValue{
                    self.allData.append(TariffModel(json: arr))
                    self.arrData=self.allData
                }
                DispatchQueue.main.async {
                    self.view.activityStopAnimating()
                    if(self.allData.count == 0){
                        self.alert(title: "No Record Found!", message: "No Tariff Details found for the selected patient.")
                    }
                }
                DispatchQueue.main.async {
                        self.tableView.reloadData()
                    
                }
                print("response")
            }catch{
                print("error")
                print(error.localizedDescription)
            }
            }.resume()
    }
    private func searchBarSetup(){
        searchController.searchResultsUpdater=self
        searchController.searchBar.delegate=self
        
        //self.searchController.dimsBackgroundDuringPresentation = false
        if #available(iOS 11.0, *) {
            navigationItem.hidesSearchBarWhenScrolling = false
            navigationItem.searchController=searchController
        } else {
            
            searchController.hidesNavigationBarDuringPresentation = true
            tableView.tableHeaderView = searchController.searchBar
        }
        
        
    }
    
    private func showAlert(message:String)  {
        DispatchQueue.main.async {
        
        let alertController = UIAlertController(title: "Info!", message:
           message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
        
            self.present(alertController, animated: true, completion: nil)
            
        }
    }
    func showAlert() {
        if !AppUtilityFunctions.isInternetAvailable() {
            let alert = UIAlertController(title: "Warning", message: "The Internet is not available", preferredStyle: .alert)
            let action = UIAlertAction(title: "Dismiss", style: .default, handler:{ (action: UIAlertAction!) in
                //                print("Handle Ok logic here")
                self.navigationController?.popToRootViewController(animated: true)
            })
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    
    func alert(title:String,message:String)
    {
        DispatchQueue.main.async {
           
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Dismiss", style: .default, handler:{ (action: UIAlertAction!) in
            //                print("Handle Ok logic here")
            self.navigationController?.popToRootViewController(animated: true)
        })
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
            
        }
    }
    
}

extension TariffViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        
        cell.labelTariffName.text = arrData[indexPath.row].tariffName
        cell.labelTariffCharge.text = "Rs. "+arrData[indexPath.row].tariffCharge
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
extension TariffViewController:UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText=searchController.searchBar.text else{return}
        if searchText==""
        {
            self.arrData=self.allData
        }
        else{
            arrData=allData
            arrData=arrData.filter{
                $0.tariffName.lowercased().contains(searchText.lowercased())
            }
        }
        tableView.reloadData()
    }
}
