//
//  ViewController.swift
//  NewsFeedApp
//
//  Created by mehtab alam on 03/02/2021.
//

import UIKit

class NewsFeedViewController: UIViewController {
    
    private var serviceInstance = Service()
    var newsArray:[Article]!
    private var pagNo = 1
    var selectedUserCount:(([Int],[String])->Void)? = nil
    var userImageList:[String] = []

    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
       
        getServerdata()
        
        
    }

    //MARK:- function for getting data from server
    func getServerdata(){
        serviceInstance.getRequest(url: "http://newsapi.org/v2/everything?q=tesla&from=2020-11-31&sortBy=publishedAt&apiKey=0a66777f477f4ca0953595fa2122c6b6", decodingType: NewsModel.self) { (result) in
            
            switch result {
            case.success(let data):
              //  let newsData = data
                guard let articleData = data.articles else {return}
               // print(newsData.articles!.count)
                self.newsArray = articleData
                print(self.newsArray.count)
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

}

//MARK:- CollectionView Delegate & data source
extension NewsFeedViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let data = newsArray {
            return data.count
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewsFeedCollectionViewCell", for: indexPath) as! NewsFeedCollectionViewCell
        cell.titleLabel.text = newsArray[indexPath.row].title
        cell.discriptionTextView.text = newsArray[indexPath.row].descriptionField
        cell.dateLabel.text = newsArray[indexPath.row].publishedAt
        let imagelink = newsArray[indexPath.row].urlToImage
        guard let link = imagelink else { return cell}
        cell.newsImage.downloaded(from: link)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let VC = self.storyboard?.instantiateViewController(withIdentifier: "NewsDetailViewController") as! NewsDetailViewController
        VC.newsArray = newsArray[indexPath.row]
        self.navigationController?.pushViewController(VC, animated: true)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 403, height: 180)
    }
}

