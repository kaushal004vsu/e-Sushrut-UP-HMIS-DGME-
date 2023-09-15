//
//  ViewDocumentViewController.swift
//  e-Sushrut HMIS SAIL Rourkela
//
//  Created by HICDAC on 07/07/22.
//

import UIKit

class ViewDocumentViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate {
    
    @IBOutlet weak var myCollectionView: UICollectionView?
    var docsList = [AllData2]()

    override func viewDidLoad() {
        super.viewDidLoad()
        myCollectionView?.dataSource=self
        myCollectionView?.delegate=self
        
        fetchDocsList()

    }
   
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        self.myCollectionView!.collectionViewLayout.invalidateLayout()
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return docsList.count
    }
    

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "dataCell", for: indexPath) as! ViewDocumentCellTableViewCell
           
               
        let city = docsList[indexPath.row]
        //print("ab "+city.document_base64!)
        //print("nsudeep");
    
            if(city.document_content_type == "image/png") {
                DispatchQueue.main.async {
//                    cell.docsImageview.image = UIImage(named: "gallery_pic")
                 
                    let dataDecoded : Data = Data(base64Encoded: self.docsList[indexPath.row].document_base64!, options: .ignoreUnknownCharacters)!
                    let decodedimage = UIImage(data: dataDecoded)
                    cell.docsImageview.image = decodedimage
                }
                
            }else{
                DispatchQueue.main.async {
                    cell.docsImageview.image = UIImage(named: "pdf_icon")
                }
                
            }
        cell.docsNameLabel.text = city.document_title
        return cell
    }
   
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if(docsList[indexPath.row].document_content_type == "image/png") {
            let showDetail:DocsDetailViewController = self.storyboard!.instantiateViewController(withIdentifier: "showDetail") as! DocsDetailViewController
            showDetail.base64Send=docsList[indexPath.row].document_base64!
           showDetail.docsTitle=docsList[indexPath.row].document_title!
           showDetail.docsType=docsList[indexPath.row].document_content_type!
            self.navigationController!.show(showDetail, sender: self)
            
        }else{
            let viewController:PdfViewController = self.storyboard!.instantiateViewController(withIdentifier: "PdfViewController") as! PdfViewController
            viewController.from = 1
            viewController.base64Send=docsList[indexPath.row].document_base64!
            viewController.docsTitle=docsList[indexPath.row].document_title!
            viewController.docsType=docsList[indexPath.row].document_content_type!
           self.navigationController!.show(viewController, sender: self)//
            
        }
        

    }
    
    
    fileprivate func fetchDocsList() {
        let obj = UserDefaults.standard.retrieve(object: PatientDetails.self, fromKey: "patientDetails")

        
        let urlString = ServiceUrl.view_docs + obj!.crno
        print("urlString----\(urlString)")
        
        DispatchQueue.main.async {
            self.view.activityStartAnimating(activityColor: UIColor.white, backgroundColor: UIColor.black.withAlphaComponent(0.5))
        }
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, err in
            guard let data = data, err == nil else { return }
            
            do {
                let jsonData = try JSONDecoder().decode(DocsViewModel.self, from: data)
                self.docsList = jsonData.documents_detail?.all_data ?? [] //append data to your productLis array
                
                DispatchQueue.main.async {
                    self.myCollectionView!.reloadData()
                
                }
                 
            } catch let jsonErr {
                print("failed to decode json:", jsonErr)
            }
            DispatchQueue.main.async {
                self.view.activityStopAnimating()
                
            }
        }.resume() // don't forget
    
    }
    
    
   
}
extension ViewDocumentViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {

        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
      
            let columns:CGFloat=4;
            let spacing:CGFloat=8
            let totalHorizontalSpacing=(columns-1) * spacing
        let itemWidth=(myCollectionView!.bounds.width-totalHorizontalSpacing)/columns
        let itemSize=CGSize(width: itemWidth, height: itemWidth * 1.8)
        return itemSize
        //return CGSize(width: collectionView.frame.size.width/3.2 , height: 100);
        
        
    }
    
//     func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
//      return 1
//    }
//
//     func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 3
//    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
      
            return 8.0
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        return 5.0
    
    }
    
}
