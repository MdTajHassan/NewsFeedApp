//
//  NewsDetailViewController.swift
//  NewsFeedApp
//
//  Created by mehtab alam on 03/02/2021.
//

import UIKit

class NewsDetailViewController: UIViewController {

    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var discriptionTextView: UITextView!
    @IBOutlet weak var dateLbl: UILabel!
    
    var newsArray:Article!
    override func viewDidLoad() {
        super.viewDidLoad()

        titleLbl.text = newsArray.title
        discriptionTextView.text = newsArray.descriptionField
        dateLbl.text = newsArray.publishedAt
        let completeLink = newsArray.urlToImage
        image.downloaded(from: completeLink!)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
